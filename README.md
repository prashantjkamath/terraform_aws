# terraform_aws
This repository has the code for creation of Private VPC, Subnet, Route table with EC2.
Also it has a creation of AWS S3 bucket through terraform.

Pre requisite:
1) Terraform installed
2) AWS CLI configured.
3) AWS secret key and secret key ID updated through AWS CLI.


Run the main.tf with below 3 steps:

1) terraform init
2) terraform plan
3) terraform apply


You can add additional subnets as required and should be referenced.
You can add number of EC2 instances with count.
You can also add variable.tf file for creating variables as necessary.
