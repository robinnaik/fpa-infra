provider "google" {
  project = "fpa-be"
}

# Create VPC Network
module "vpc_network" {
    source                  = "../../modules/network"
    project_id              = var.project_id
    region                  = var.region
    env                     = var.env
    primary-subnet-range    = var.primary-subnet-range
    secondary-cluster-ips   = var.secondary-cluster-ips
    secondary-service-ips   = var.secondary-service-ips
    peer_project            = var.peer_project
}

# Adding subnet
resource "google_compute_subnetwork" "loadbalancer-subnet" {
  name          = "${var.project_id}-${var.env}-loadbalancer-subnet"
  ip_cidr_range = var.ip-loadbalancer-subnet-ip-range
  region        = var.region
  network       = module.vpc_network.network_id
}

# Create firewall rule
# TODO: REview firewall rules to make it more restricted
module "firewall_rules" {
    source                  = "../../modules/firewall_rules"
    project_id              = var.project_id
    env                     = var.env
    vpc_network_name        = module.vpc_network.network_name
    tcp_source_ranges      = ["0.0.0.0/0"]
    icmp_source_ranges      = ["0.0.0.0/0"]
    tcp_ports               = ["80","8080","443","22"]
}

# Create Cloud NAT to allow services to connect to MongoDB Cloud
module "cloud_nat" {
    source                  = "../../modules/cloud_nat"
    project_id              = var.project_id
    env                     = var.env
    vpc_network_name        = module.vpc_network.network_name
    region                  = var.region
}

# Create Peering
module "cloud_vpc_peering" {
    source                  = "../../modules/vpc_peering"
    project_id              = var.project_id
    peer_project            = var.peer_project
    vpc_network_id          = module.vpc_network.network_id
    # Assumes that same vpc_peer module is used by peer project
    vpc_peer_network_id     = "projects/${var.peer_project}/global/networks/${var.peer_project}-${var.env}-network"
}

# Create Cluster
module "cluster" {
    source                      = "../../modules/cluster"
    project_id                  = var.project_id
    env                         = var.env
    vpc_network_name            = module.vpc_network.network_name
    region                      = var.region
    vpc_subnet_name             = module.vpc_network.subnet1_name
    cluster_control_plan_cidr   = var.cluster-control-plane-cidr
    cluster_ip_range            = module.vpc_network.secondary-cluster-ips
    service_ip_range            = module.vpc_network.secondary-service-ips
    app_stack                   = "backend"
}