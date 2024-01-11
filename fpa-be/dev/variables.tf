variable "project_id" {
  description = "The project ID to host the cluster in"
  default = "fpa-be"
}

variable "env" {
  description = "The name for the GKE cluster"
  default     = "dev"
}

variable "region" {
  description = "Region for the cluster"
  default = "asia-south1"
}

variable "primary-subnet-range" {
  description = "Primary Subet Range"
  default = "10.192.0.0/21"
}

variable "secondary-cluster-ips" {
  description = "Secondary Range to be used for Cluster IPs"
  default = "10.192.16.0/21"
}

variable "secondary-service-ips" {
  description = "Secondary Range to be used by Services"
  default = "10.192.24.0/21"
}

variable "cluster-control-plane-cidr" {
  description = "CIDR block for control plane of GKE"
  default = "10.192.14.0/28"
}

variable "ip-loadbalancer-subnet-ip-range" {
  description = "CIDR block for Loadbalancer subnet plane of GKE"
  default = "10.192.12.0/26"
}

variable "peer_project" {
  description = "Peer network"
  default = "fpa-fe"
}

variable "proxy_only_subnet_ip_range" {
  description = "Proxy only subnet for internal application loadbalancer"
  default = "10.192.34.0/23"
}