# Example on how to create an account deployment with a VPC setup

local {
  account_name = "fredbob"

  features = {
    users   = false
    vpc     = true
    infosec = true
    dns     = true
  }
}

module "deploy" {
  source       = "github.com/mozilla-it/itsre-deploy?ref=master"
  account_name = "${local.account_name}"
  features     = "${local.features}"
}

output "vpc_id" {
  value = "${module.deploy.vpc_id}"
}
