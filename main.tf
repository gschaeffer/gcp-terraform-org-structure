############################################################################
### Based on Google & Hashicorp GCP modules, https://registry.terraform.io/
###   (https://github.com/terraform-google-modules)
### Other references
### https://stedolan.github.io/jq/
############################################################################


# Management node contains cloud administrative functions like log archives, 
# security & governance controls (Foresetti), etc.
resource "google_folder" "management-folder" {
  display_name = "Management"
  parent       = "organizations/${var.org_id}"
}


resource "google_folder" "group-a" {
  display_name = "Group A"
  #parent       = "organizations/${var.org_id}"
  parent = google_folder.management-folder.name
}
