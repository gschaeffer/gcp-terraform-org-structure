############################################################################
### Based on Google & Hashicorp GCP modules, https://registry.terraform.io/
###   (https://github.com/terraform-google-modules)
### Other references
### https://stedolan.github.io/jq/
############################################################################

module "project-factory-log-archive" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 4.0"

  org_id    = var.org_id
  folder_id = "${google_folder.management-folder.name}"

  name = "log-archive"
  #project_id        = ""
  random_project_id = "true"

  auto_create_network = "true"
  billing_account     = var.billing_account

  activate_apis = var.activate_apis
}


############################################################################
### Cloud Storage.
############################################################################

resource "google_storage_bucket" "activity-logs" {
  name          = "activity-logs-${var.org_id}"
  location      = "us-central1"
  project       = module.project-factory-log-archive.project_id
  storage_class = "standard"
}