resource "google_project_service" "recaptcha_api" {
  project = var.project_id
  service = "recaptchaenterprise.googleapis.com"
}
