provider "google" {
  project = "fpa-be"
  region  = "asia-south1"
}

resource "google_service_account" "default" {
  account_id   = "fpa-gke-service-account"
  display_name = "Service Account"
}

resource "google_compute_router" "nat-router" {
  name    = "nat-router"
  region  = "asia-south1"
  network = "fpa-be-network"

  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "address" {
  count  = 2
  name   = "nat-manual-ip-${count.index}"
  region = "asia-south1"
}

resource "google_compute_router_nat" "nat" {
  name                               = "google-nat"
  router                             = google_compute_router.nat-router.name
  region                             = google_compute_router.nat-router.region
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.address.*.self_link
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
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
  initial_node_count = 1
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
    master_ipv4_cidr_block = "172.16.0.32/28"
  }

  master_authorized_networks_config {}

  node_config {
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
  timeouts {
    create = "30m"
    update = "40m"
  }
}