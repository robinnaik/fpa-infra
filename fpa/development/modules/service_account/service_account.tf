resource "google_service_account" "gcr_service_account" {
  account_id   = "cloud-run-service-account"
  display_name = "Google Cloud Run Service Account"
}

resource "google_project_iam_binding" "gcr_service_account_binding_run_service_agent" {
  project     = var.project_id
  role        = "roles/run.serviceAgent"
  members     = [
    "serviceAccount:service-${var.project_number}@serverless-robot-prod.iam.gserviceaccount.com"
  ]
}

resource "google_project_iam_binding" "gcr_service_account_binding_secret_manager" {
  project     = var.project_id
  role        = "roles/secretmanager.secretAccessor"
  members     = [
    "serviceAccount:${google_service_account.gcr_service_account.email}"
  ]
}