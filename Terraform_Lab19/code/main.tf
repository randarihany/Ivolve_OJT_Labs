provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"

  vpc_id             = "vpc-0aa97f2a42080bf4f" # Replace with the actual VPC ID
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "server1" {
  source = "./modules/server"

  vpc_id        = "vpc-0aa97f2a42080bf4f" # Replace with the actual VPC ID
  subnet_id     = module.network.public_subnet_ids[0]
  ami_id        = "ami-0c02fb55956c7d316" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  instance_name = "server1" # Pass the instance_name variable
}

module "server2" {
  source = "./modules/server"

  vpc_id        = "vpc-0aa97f2a42080bf4f" # Replace with the actual VPC ID
  subnet_id     = module.network.public_subnet_ids[1]
  ami_id        = "ami-0c02fb55956c7d316" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  instance_name = "server2" # Pass the instance_name variable
}
