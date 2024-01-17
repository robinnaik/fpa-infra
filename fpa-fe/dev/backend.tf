## Please create bucket manually for terraform as it is one time creation (can be automated later)
#TODO: Automate creation of bucket later
terraform {
 backend "gcs" {
   bucket  = "fpa-fe-terraform"
   prefix  = "terraform/state"
 }
}