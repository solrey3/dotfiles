provider "google" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  host  = google_container_cluster.primary.endpoint
  token = data.google_client_config.default.access_token

  client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    token                  = data.google_client_config.default.access_token
    client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  }
}

variable "project_id" {}
variable "region" {}
variable "gke_cluster_name" {}

resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.region

  initial_node_count = 3

  node_config {
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

data "google_client_config" "default" {}

resource "google_sql_database_instance" "postgres" {
  name             = "postgres-instance"
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "database" {
  name     = "mydatabase"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "users" {
  name     = "user"
  instance = google_sql_database_instance.postgres.name
  password = "mypassword"
}

resource "google_storage_bucket" "media_bucket" {
  name     = "anycompany-media-bucket"
  location = var.region
}

resource "google_logging_project_sink" "my-sink" {
  name        = "my-sink"
  destination = "storage.googleapis.com/${google_storage_bucket.media_bucket.name}"
}

resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "GitHub Actions Service Account"
}

resource "google_project_iam_binding" "github_actions_bind" {
  role    = "roles/editor"
  members = [
    "serviceAccount:${google_service_account.github_actions.email}",
  ]
}

resource "google_compute_address" "external_ip" {
  name = "external-ip"
}

resource "google_compute_address" "admin_ip" {
  name = "admin-ip"
}

resource "google_compute_ssl_policy" "custom_ssl_policy" {
  name = "custom-ssl-policy"
  profile = "MODERN"
  min_tls_version = "TLS_1_2"
  custom_features = ["TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256", "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"]
}

module "artifact_registry" {
  source  = "terraform-google-modules/artifact-registry/google"
  version = "~> 1.0"

  project_id = var.project_id
  location   = var.region
  repository = "docker-repo"
}

module "cert_manager" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/cert-manager"
  version = "~> 9.0"

  project_id       = var.project_id
  location         = var.region
  cluster_name     = google_container_cluster.primary.name
  cluster_location = google_container_cluster.primary.location
}

resource "kubernetes_namespace" "redis_namespace" {
  metadata {
    name = "redis"
  }
}

resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  namespace  = kubernetes_namespace.redis_namespace.metadata[0].name

  set {
    name  = "cluster.enabled"
    value = "true"
  }
}

resource "google_bigquery_dataset" "maps_dataset" {
  dataset_id = "maps_data"
  project    = var.project_id
}

resource "google_bigquery_dataset" "recaptcha_dataset" {
  dataset_id = "recaptcha_data"
  project    = var.project_id
}

resource "google_compute_instance" "backup_script" {
  name         = "db-backup"
  machine_type = "f1-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    while true; do
      gcloud sql export sql ${google_sql_database_instance.postgres.name} gs://${google_storage_bucket.media_bucket.name}/db-backups/db-backup-$(date +%Y%m%d).gz --database=${google_sql_database.database.name}
      sleep 86400
    done
    EOT
}
