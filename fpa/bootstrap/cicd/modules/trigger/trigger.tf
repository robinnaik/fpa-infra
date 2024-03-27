resource "google_cloudbuild_trigger" "fpa-cloud-build" {
  location = var.region
  name     = "build-${var.service}-trigger"
  service_account = var.service_account
  filename = "cloudbuild.yml"

  github {
    owner = "robinnaik"
    name  = "fpa-${var.service}"
    push {
      branch = "^main$"
    }
  }
}
