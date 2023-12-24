provider "google" {
  project = "fpa-be"
  region  = "asia-south1"
}

resource "google_service_account" "default" {
  account_id   = "fpa-gke-service-account"
  display_name = "Service Account"
}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
}

resource "google_container_cluster" "primary" {
  name               = "fpa-be-dev"
  location           = "asia-south1"
  network            = "projects/fpa-be/global/networks/fpa-be-network"
  subnetwork         = "projects/fpa-be/regions/asia-south1/subnetworks/fpa-be-subnet1"
  remove_default_node_pool = true
  initial_node_count = 1
}

resource "google_container_node_pool" "primary_cluster_node_pool" {
  name       = "fpa-be-node-pool"
  cluster    = google_container_cluster.primary.id
  autoscaling {
    min_node_count = 2
    max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = 10

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      app = "fpa"
      type = "backend"
    }
  }
}