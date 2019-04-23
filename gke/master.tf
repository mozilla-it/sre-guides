terraform {
  backend "gcs" {
    bucket = "afrank-data-terraform-0"
  }
}

provider "google-beta" {
  credentials = "${file(var.creds-file)}"
  project     = "${var.project_id}"
}

provider "google" {
  credentials = "${file(var.creds-file)}"
  project     = "${var.project_id}"
}

module "gke" {
  source       = "git@github.com:mozilla-it/terraform-sre-gke.git"
  cluster_name = "${var.cluster_name}"
  project_id   = "${var.project_id}"
  creds-file   = "${var.creds-file}"
  ssh_username = "${var.ssh_username}"
  ssh_password = "${var.ssh_password}"
}
