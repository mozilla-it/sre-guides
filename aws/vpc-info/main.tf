# This is an example of how to reference a vpc_id
# using the itsre-sandbox account as reference

data "terraform_remote_state" "deploy" {
  backend = "s3"

  config = {
    bucket = "itsre-state-517826968395"
    key    = "terraform/deploy.tfstate"
    region = "eu-west-1"
  }
}

output "vpc_id" {
  value = data.terraform_remote_state.deploy.outputs.vpc_id
}

# It's also possible to output subnet ids
output "public_subnets" {
  value = data.terraform_remote_state.deploy.outputs.public_subnets
}

output "private_subnets" {
  value = data.terraform_remote_state.deploy.outputs.private_subnets
}

