resource "google_cloudbuild_trigger" "fpa-cloud-build" {
  location = var.region
  name     = "fpa-${var.service}-build"
  filename = "cloudbuild.yml"
  github {
    owner = "robinnaik"
    name  = "fpa-${var.service}"
    push {
      branch = "^main$"
    }
  }
}
