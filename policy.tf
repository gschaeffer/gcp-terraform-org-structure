############################################################################
### https://registry.terraform.io/modules/terraform-google-modules/org-policy/google/3.0.1
###
### Organizational policies.
### TO DO: 
### - domain restrictions: constraints/iam.allowedPolicyMemberDomains
############################################################################

module "org-policy-regions" {
  source          = "terraform-google-modules/org-policy/google"
  policy_for      = "organization"
  organization_id = var.org_id
  constraint      = "constraints/gcp.resourceLocations"
  policy_type     = "list"

  allow             = var.policy-resourceLocations
  allow_list_length = "1"
  # recommended tag is not currently supported.
  # recommended       = "Resources may only be created in US regions."
}

module "org-policy-default-vpc" {
  source          = "terraform-google-modules/org-policy/google"
  policy_for      = "organization"
  organization_id = var.org_id
  constraint      = "constraints/compute.skipDefaultNetworkCreation"
  policy_type     = "boolean"
  enforce         = var.policy-skipDefaultNetworkCreation
}