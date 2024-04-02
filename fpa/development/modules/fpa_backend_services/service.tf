resource "google_cloud_run_v2_service" "default" {
  name = "${var.service_name}-${var.env}"
  location = var.region
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  launch_stage = "BETA"    
  template {
    service_account = var.service_account
    containers {
      image = "asia-south1-docker.pkg.dev/fpa-be/docker-images/${var.service_name}"
      ports {
        container_port = var.service_port
      }
      env {
        name = "mongo.db.dbname"
        value = "fpa-dev"
      }
      env {
        name = "mongo.db.connection.string"
        value_source {
          secret_key_ref {
            version = 1
            secret = "projects/${var.project_number}/secrets/mongo-db-connection-string"
          }
        }
      }
      env {
        name = "CALCULATORS_BASE_URL"
        value = "https://asia-south1-fpa-dev-1.cloudfunctions.net"
      }
    }
    vpc_access{
      network_interfaces {
        network = "default"
        subnetwork = "default"
      }
      egress = "ALL_TRAFFIC"
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