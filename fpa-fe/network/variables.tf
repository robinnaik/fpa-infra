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
  default = "10.160.200.0/24"
}

variable "secondary-range-1" {
  description = "Secondary Range 1 for pods"
  default = "10.160.201.0/24"
}

variable "secondary-range-2" {
  description = "Secondary Range 1 for pods"
  default = "10.160.202.0/24"
}

variable "peer_project" {
  description = "Peer network"
  default = "fpa-be"
}