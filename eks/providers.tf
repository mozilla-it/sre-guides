provider "aws" {
  region  = "${var.region}"
  version = ">= 2.6.0"
}

provider "random" {
  version = "= 1.3.1"
}

provider "local" {}
