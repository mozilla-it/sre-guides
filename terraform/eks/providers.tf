provider "aws" {
  region  = var.region
  version = ">= 2.46.0"
}

provider "random" {
  // if you experience any problem with the new vresion, check this https://github.com/terraform-providers/terraform-provider-random/blob/master/CHANGELOG.md
  version = "= 2.2.1"
}

provider "local" {
}

