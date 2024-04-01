

resource "google_cloud_run_v2_service" "default" {
  name = "${var.service_name}-${var.env}"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"    
  template {
    service_account = var.service_account
    containers {
      image = "asia-south1-docker.pkg.dev/fpa-fe/docker-images/${var.service_name}"
      ports {
        container_port = var.service_port
      }
      env {
        name = "LOGIN_API"
        value = var.login_api
      }
    }
  }
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  name = google_cloud_run_v2_service.default.name
  location = google_cloud_run_v2_service.default.location
  project = google_cloud_run_v2_service.default.project
  policy_data = data.google_iam_policy.admin.policy_data
}