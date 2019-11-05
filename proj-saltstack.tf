############################################################################
### Based on Google & Hashicorp GCP modules, https://registry.terraform.io/
###   (https://github.com/terraform-google-modules)
### Other references
### https://stedolan.github.io/jq/
############################################################################


locals {
  network_name = "main-vpc"
  firewalls = {
    icmp     = "${local.network_name}-allow-icmp"
    ssh      = "${local.network_name}-allow-ssh"
    rdp      = "${local.network_name}-allow-rdp"
    internal = "${local.network_name}-allow-internal"
  }
}


module "project-factory-saltstack" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 4.0"

  org_id    = var.org_id
  folder_id = "${google_folder.management-folder.name}"

  name              = "saltstack"
  random_project_id = "true"

  auto_create_network = "true"
  billing_account     = var.billing_account

  activate_apis = var.activate_apis
}


############################################################################
### VPC.
############################################################################

module "network-saltstack" {
  source  = "terraform-google-modules/network/google"
  version = "1.4.3"

  project_id   = module.project-factory-saltstack.project_id
  network_name = local.network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "subnet-1"
      subnet_ip     = "192.168.0.0/24"
      subnet_region = "us-central1"
    }
  ]

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },
  ]
}


############################################################################
### Firewall rules.
############################################################################
resource "google_compute_firewall" "salt-icmp" {
  name    = "${local.firewalls["icmp"]}"
  project = "${module.project-factory-saltstack.project_id}"
  network = "${module.network-saltstack.network_name}"

  allow {
    protocol = "icmp"
  }
  source_tags = ["icmp"]
}

resource "google_compute_firewall" "salt-ssh" {
  name    = "${local.firewalls["ssh"]}"
  project = "${module.project-factory-saltstack.project_id}"
  network = "${module.network-saltstack.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_tags = ["ssh"]
}

resource "google_compute_firewall" "salt-rdp" {
  name    = "${local.firewalls["rdp"]}"
  project = "${module.project-factory-saltstack.project_id}"
  network = "${module.network-saltstack.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_tags = ["rdp"]
}

resource "google_compute_firewall" "salt-internal" {
  name    = "${local.firewalls["internal"]}"
  project = "${module.project-factory-saltstack.project_id}"
  network = "${module.network-saltstack.network_name}"

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = ["192.168.0.0/24"]
}