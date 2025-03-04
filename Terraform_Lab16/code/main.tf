# Specify the required providers for Terraform to interact with AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # AWS provider source
      version = "~> 5.0"         # Version constraint for the AWS provider
    }
  }
}

# Configure the AWS provider, which allows Terraform to communicate with AWS
provider "aws" {
  region = "us-east-1"  # Set the AWS region where resources will be created
}
