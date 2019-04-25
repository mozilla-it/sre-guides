# Account deployment

Our [account deployment](https://github.com/mozilla-it/itsre-deploy) process creates several standard resources along with some other optional ones. At a minimum it creates the following:

* A DNS hosted zone in the form of `${account_name}.mozit.cloud`
* A cloudhealth role
* Enables cloudtrail on all regions
* Enables opsec roles
* Sets password policy and account alias

## Other options
The account deployment process is also capable of creating several other items such as:

* VPC
	* By default it creates 3 public and private subnets
	* 1 NAT instances
	* S3 endpoint
	* Dynamodb Endpoint
* Users
	* It can create IAM users with API keys and roles associated with it
