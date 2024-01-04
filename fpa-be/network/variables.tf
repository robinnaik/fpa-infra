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

variable "proxy-only-subnet-range" {
  description = "Proxy only subnet range for internal regional load balancer"
  default = "10.192.34.0/23"
}

variable "secondary-cluster-ips" {
  description = "Secondary Range to be used for Cluster IPs"
  default = "10.192.16.0/21"
}

variable "secondary-service-ips" {
  description = "Secondary Range to be used by Services"
  default = "10.192.24.0/21"
}

variable "peer_project" {
  description = "Peer network"
  default = "fpa-fe"
}

variable "peer-subnet-range" {
  description = "Peer Subet Range"
  default = "10.192.80.0/21"
}