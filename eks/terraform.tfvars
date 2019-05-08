environment = "dev"

region = "us-west-2"

cluster_version = "1.12"

# https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html
available_amis = {
  "us-west-2"      = "ami-0923e4b35a30a5f53"
  "us-east-1"      = "ami-0abcb9f9190e867ab"
  "us-east-2"      = "ami-04ea7cb66af82ae4a"
  "eu-central-1"   = "ami-0d741ed58ca5b342e"
  "eu-north-1"     = "ami-0c65a309fc58f6907"
  "eu-west-1"      = "ami-08716b70cac884aaa"
  "eu-west-2"      = "ami-0c7388116d474ee10"
  "eu-west-3"      = "ami-0560aea042fec8b12"
  "ap-northeast-1" = "ami-0bfedee6a7845c26d"
  "ap-northeast-2" = "ami-0a904348b703e620c"
  "ap-south-1"     = "ami-09c3eb35bb3be46a4"
  "ap-southeast-1" = "ami-07b922b9b94d9a6d2"
  "ap-southeast-2" = "ami-0f0121e9e64ebd3dc"
}
