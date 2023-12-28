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
  default = "10.160.100.0/24"
}

variable "secondary-range-1" {
  description = "Secondary Range 1 for pods"
  default = "10.160.101.0/24"
}

variable "secondary-range-2" {
  description = "Secondary Range 1 for pods"
  default = "10.160.102.0/24"
}