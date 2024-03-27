provider "google" {
  project = "fpa-b-cicd"
}

resource "google_service_account" "gcb_service_account" {
  account_id   = "gcb-service-account"
  display_name = "Google Cloud Build Service Account"
}

resource "google_project_iam_binding" "gcb_service_account_binding_builder" {
  project     = var.project_id
  role        = "roles/cloudbuild.builds.builder"
  members     = [
    "serviceAccount:${google_service_account.gcb_service_account.email}"
  ]
}

module "build-common" {
  source                  = "./modules/trigger"
  region                  = var.region
  service                 = "common"
  service_account         = google_service_account.gcb_service_account.id
}