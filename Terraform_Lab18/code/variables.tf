#declare variables

variable region {

    type = string
    
}
variable vpc_cidr_block {

    type = string
    description = " VPC Cidr block Ip"
}

variable subnet_cidr_block {

    type = list(string)
    description = "Subnets Cidr Block List"
}

variable subnet_az {

    type = list(string)
    description = "Subnets avalability zone List"
}


variable instance_ami {

    type = string
}


variable instance_type {

    type = string
}
