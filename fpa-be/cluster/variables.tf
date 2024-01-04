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

variable "gke_service_account" {
  description = "Service account for cluster"
  default = "fpa-be-gke-service-account"
}