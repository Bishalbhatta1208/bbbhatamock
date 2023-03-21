

#----------------------------------------------------------
# CLO835 - Assignment1 - Terraform for Ecr
#
# Build ECR
#
#----------------------------------------------------------

#  Define the provider
provider "aws" {
  region = "us-east-1"
}



# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_ecr_repository" "ecr" {
  for_each             = toset(var.ecr_name)
  name                 = each.key
  image_tag_mutability = var.image_mutability
  encryption_configuration {
    encryption_type = var.encrypt_type
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.tags
}