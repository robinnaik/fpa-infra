provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "default" {
  account_id   = "${var.gke_service_account}-${var.env}"
  display_name = "Service Account"
}

resource "google_project_iam_binding" "gke_service_account_binding" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  members  = [
    "serviceAccount:${google_service_account.default.email}"
  ]
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
  name               = "${var.project_id}-${var.env}"
  location           = var.region
  network            = "${var.project_id}-${var.env}-network"
  subnetwork         = "${var.project_id}-${var.env}-subnet1"
  remove_default_node_pool = true
  deletion_protection=false
  initial_node_count = 1

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes   = true 
    master_ipv4_cidr_block = "10.192.8.16/28"
  }

  ip_allocation_policy{
    cluster_secondary_range_name = "${var.project_id}-${var.env}-cluster-ips"
    services_secondary_range_name = "${var.project_id}-${var.env}-service-ips"
  }
}

resource "google_container_node_pool" "primary_cluster_node_pool" {
  name       = "${var.project_id}-node-pool"
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
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
    
}