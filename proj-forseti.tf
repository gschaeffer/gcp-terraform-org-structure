############################################################################
### Based on Google & Hashicorp GCP modules, https://registry.terraform.io/
###   (https://github.com/terraform-google-modules)
### Other references
### https://stedolan.github.io/jq/
############################################################################

module "project-factory-forseti" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 4.0"

  org_id    = var.org_id
  folder_id = "${google_folder.management-folder.name}"

  name = "forseti"
  #project_id        = ""
  random_project_id = "true"

  auto_create_network = "true"
  billing_account     = var.billing_account

  activate_apis = var.activate_apis
}