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

resource "google_container_cluster" "gcp_kubernetes" {
    provider           = "google-beta"
    name               = "${var.cluster_name}"
    location           = "us-west1-a"
    project            = "${var.project_id}"
    initial_node_count = 1
    min_master_version = "1.12"
    remove_default_node_pool = true
    master_auth {
        username = "<some username you supply>"
        password = "<some password you supply>"
    }
    cluster_autoscaling {
        enabled = true
        resource_limits {
            resource_type = "cpu"
            maximum = 16
        }
        resource_limits {
            resource_type = "memory"
            maximum = 64
        }
    }
    addons_config {
        http_load_balancing {
            disabled = false
        }
    }
}

resource "google_container_node_pool" "np_kubernetes" {
    provider           = "google-beta"
    name               = "${var.cluster_name}-node-pool-0"
    location           = "us-west1-a"
    project            = "${var.project_id}"
    initial_node_count = 1
    node_config {
        preemptible  = true
        oauth_scopes = [
          "https://www.googleapis.com/auth/compute",
          "https://www.googleapis.com/auth/devstorage.read_only",
          "https://www.googleapis.com/auth/logging.write",
          "https://www.googleapis.com/auth/monitoring",
        ]
        tags = ["afrank"]
    }
    autoscaling	{
        min_node_count = 1
        max_node_count = 5
    }
    cluster            = "${var.cluster_name}"
    management {
        auto_upgrade = true
        auto_repair  = true
    }
}
