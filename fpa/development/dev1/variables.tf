variable "project_id" {
  description = "The project ID"
  default = "fpa-dev-1"
}

variable "project_number" {
  description = "The project number"
  default = "606010765839"
}

variable "env" {
  description = "The name for the GKE cluster"
  default     = "dev-1"
}

variable "region" {
  description = "Region for the cluster"
  default = "asia-south1"
}

