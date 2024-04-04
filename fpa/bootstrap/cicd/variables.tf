variable "project_id" {
  description = "The project ID to host the cluster in"
  default = "fpa-b-cicd"
}

variable "build_region" {
  description = "Building region"
  default = "global"
}

variable "services" {
  default = ["common",
              "login-service",
              "asset-management-service",
              "liability-management-service",
              "expense-management-service",
              "income-management-service",
              "ui-service"
            ]
  }