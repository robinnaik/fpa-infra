variable "project_id" {
  description = "The project ID to host the cluster in"
  default = "fpa-fe"
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
  default = "10.192.64.0/21"
}

variable "secondary-cluster-ips" {
  description = "Secondary Range to be used for Cluster IPs"
  default = "10.192.80.0/21"
}

variable "secondary-service-ips" {
  description = "Secondary Range to be used by Services"
  default = "10.192.88.0/21"
}

variable "cluster-control-plane-cidr" {
  description = "CIDR block for control plane of GKE"
  default = "10.192.72.16/28"
}

variable "peer_project" {
  description = "Peer network"
  default = "fpa-be"
}