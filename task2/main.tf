terraform {
  required_version = ">= 0.12.26"
  backend "s3" {
    bucket = "xxxx-terraform-states"
    key    = "common.tfstate"
    profile = "xxxx-tfstate"
    region = "eu-central-1"
    encrypt = "true"
    kms_key_id = "xxxxxx-1384-468f-8706-f634f1cc43a5"
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region     = var.AWS_REGION
  version = "= 2.64.0"
}

data "aws_availability_zones" "all" {}

