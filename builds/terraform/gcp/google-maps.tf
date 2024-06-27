resource "google_project_service" "maps_api" {
  project = var.project_id
  service = "maps.googleapis.com"
}
