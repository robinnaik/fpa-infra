provider "google" {
  project = "fpa-fe"
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

# Create firewall rule
module "firewall_rules" {
    source                  = "../../modules/firewall_rules"
    project_id              = var.project_id
    env                     = var.env
    vpc_network_name        = module.vpc_network.network_name
    tcp_source_ranges      = ["0.0.0.0/0"]
    icmp_source_ranges      = ["0.0.0.0/0"]
    tcp_ports               = ["80","8080","443","22"]
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