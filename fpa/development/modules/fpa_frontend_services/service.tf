

resource "google_cloud_run_v2_service" "default" {
  name = "${var.service_name}-${var.env}"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"
  launch_stage = "BETA"    
  template {
    service_account = var.service_account
    containers {
      image = "asia-south1-docker.pkg.dev/fpa-b-cicd/docker-images/${var.service_name}"
      ports {
        container_port = var.service_port
      }
      env {
        name = "LOGIN_API"
        value = var.login_api
      }
      env {
        name = "ASSETS_API"
        value = var.asset_mgmt_api
      }
      env {
        name = "LIABILITIES_API"
        value = var.liability_mgmt_api
      }
      env {
        name = "EXPENSES_API"
        value = var.expense_mgmt_api
      }
      env {
        name = "INCOMES_API"
        value = var.income_mgmt_api
      }
    }
    vpc_access{
      network_interfaces {
        network = var.network
        subnetwork = var.subnet
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