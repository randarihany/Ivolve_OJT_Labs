region              = "us-east-1"
vpc_cidr_block      = "10.0.0.0/16"
subnet_cidr_blocks  = ["10.0.0.0/24", "10.0.1.0/24"]
subnet_az           = ["us-east-1a", "us-east-1b"]
subnet_name         = ["public subnet", "private subnet"]
instance_ami        = "ami-0c02fb55956c7d316"
instance_type       = "t2.micro"
