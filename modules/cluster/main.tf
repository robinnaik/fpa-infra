resource "google_service_account" "gke-service-account" {
  account_id   = "${var.project_id}-gke-service-account-${var.env}"
  display_name = "GKE Service Account for ${var.project_id}-${var.env} cluster"
}

resource "google_project_iam_binding" "gke_service_account_binding" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  members  = [
    "serviceAccount:${google_service_account.gke-service-account.email}"
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
  network            = var.vpc_network_name
  subnetwork         = var.vpc_subnet_name
  deletion_protection=false
  initial_node_count = 1

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes   = true 
    master_ipv4_cidr_block = var.cluster_control_plan_cidr
  }

  ip_allocation_policy{
    cluster_secondary_range_name = var.cluster_ip_range
    services_secondary_range_name = var.service_ip_range
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = 10

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke-service-account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      app = "fpa"
      type = var.app_type
      env = var.env
    }
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}