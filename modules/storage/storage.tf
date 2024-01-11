provider "google" {
  project = var.project_id
  region = var.region
}

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  force_destroy = false
  uniform_bucket_level_access = true
}
