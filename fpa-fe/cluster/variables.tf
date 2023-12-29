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
