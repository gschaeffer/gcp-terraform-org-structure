############################################################################
### Based on Google & Hashicorp GCP project-factory.
### https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/4.0.1
############################################################################

variable "auto_create_network" {
  default     = false
  description = "Create the default network"
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
}

variable "org_id" {
}

variable "folder_id" {
  default = ""
}

variable "credentials_path" {
  description = "Path to a service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fall back to Application Default Credentials."
}

variable "terraform_bucket_project" {
  description = "A project to create a GCS bucket (bucket_name) in, useful for Terraform state (optional)"
}

variable "terraform_bucket_name" {
  default     = "terraform"
  description = "A name for a GCS bucket to create (in the bucket_project project), useful for Terraform state (optional)"
}

variable "terraform_bucket_location" {
  default     = "us-central1"
  description = "The location for a GCS bucket to create (optional)"
}

variable "group_name" {
  default     = ""
  description = "A group to control the project by being assigned group_role (defaults to project editor)"
}

variable "activate_apis" {
  description = "The list of apis to activate within the project"
  default = [
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "admin.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com"
  ]
}

variable "policy-skipDefaultNetworkCreation" {
  description = "Boolean to control default VPC creation."
  default     = "false"
}

variable "policy-resourceLocations" {
  description = "List of allowed regions for resources."
  default     = ["All"]
}
