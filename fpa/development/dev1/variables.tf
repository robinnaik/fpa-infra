variable "project_id" {
  description = "The project ID"
  default = "fpa-dev-1"
}

variable "project_number" {
  description = "The project number"
  default = "606010765839"
}

variable "env" {
  description = "The name for the GKE cloud run"
  default     = "dev-1"
}

variable "region" {
  description = "Region for the cloud run"
  default = "asia-south1"
}

variable "primary-subnet-range" {
  description = "Region for the cloud run"
  default = "10.160.0.0/16"
}

variable "services" {
  default = {
    login = {
      port = "26001"
    },
    asset-management = {
      port = "26051"
    },
    liability-management = {
      port = "26052"
    },
    expense-management = {
      port = "26053"
    },
    income-management = {
      port = "26054"
    }    
  }
}
