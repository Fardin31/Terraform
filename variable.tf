variable "aws_vpc" {
  type = object({
    cidr_block       = string,
    instance_tenancy = string,
  })
}

variable "vpc_name" {
  type = string
}

variable "pub_subnet" {
  type = object({
    pub_1_cidr = string,
    pub_1_az   = string,
    pub_2_cidr = string,
    pub_2_az   = string
  })
}

variable "pri_subnet" {
  type = object({
    pri_1_cidr = string,
    pri_1_az   = string,
    pri_2_cidr = string,
    pri_2_az   = string
  })
}

variable "sub_name_pub_1" {
  type = string
}

variable "sub_name_pub_2" {
  type = string
}

variable "sub_name_pri_1" {
  type = string
}

variable "sub_name_pri_2" {
  type = string
}

variable "ig_name" {
  type = string
}

variable "eip_domain" {
  type = string
}

variable "nat_ig_name" {
  type = string
}

variable "public_route_name" {
  type = string
}
variable "private_route_name" {
  type = string
}
variable "route_table" {
  type = object({
    cidr_block = string
  })
}

variable "web_security_group" {
  type = object({
    name        = string,
    description = string,
  })
}
variable "web_sg_ingress" {
  type = object({
    description_1 = string,
    description_2 = string,
    description_3 = string,
    from_port_1   = number,
    to_port_1     = number,
    from_port_2   = number,
    to_port_2     = number,
    from_port_3   = number,
    to_port_3     = number,
    protocol      = string,
    cidr_blocks   = string
  })
}

variable "sg_egress" {
  type = object({
    from_port = number,
    to_port = number,
    protocol =string,
    cidr_blocks =string
  })
}

variable "app_security_group" {
  type = object({
    name        = string,
    description = string,
  })
}
variable "app_sg_ingress" {
  type = object({
    description_1 = string,
    description_2 = string,
    description_3 = string,
    from_port_1   = number,
    to_port_1     = number,
    from_port_2   = number,
    to_port_2     = number,
    from_port_3   = number,
    to_port_3     = number,
    protocol      = string
  })
}

variable "aws_key_pair" {
  type = object({
    key_name = string,
    public_key = string
  })
}
variable "web_instance" {
  type = object({
    ami   = string
    instance_type  = string
    associate_public_ip_address = bool
  })
}
variable "web_tags" {
  type = string
}
variable "app_instance" {
  type = object({
    ami   = string
    instance_type  = string
  })
}
variable "app_tags" {
  type = string
}
variable "rds_sg" {
  type = object({
    name = string
    description = string
  })
}
variable "rds_sg_ingress" {
  type = object({
    description = string
    from_port = number
    to_port = number
    protocol = string
  })
}
variable "rds_subnet_group" {
  type = object({
    name = string
  })
}
variable "rds_subnet_group_tags" {
  type = string
}
variable "aws_db_instance" {
  type = object({
    allocated_storage  = number
    db_name = string
    engine = string
    engine_version =string
    instance_class = string
    username = string
    password = string
    parameter_group_name = string
    skip_final_snapshot = bool
  })
}
//bucket
variable "bucket" {
  type = string
  }
 variable "bucket_name" {
   type = string
 }
 variable "env" {
   type = string
 }

 //application_load_balancer_sg
 variable "application_lb_sg" {
   type = object({
     name = string
     description = string
   })
 }
 variable "app_lb_ingress" {
   type = object({
     description = string
     from_port = number
     to_port = number
     protocol = string
     cidr_blocks = string
   })
 }
 variable "app_lb_egress" {
   type = object({
     from_port = number
     to_port = number
     protocol = string
   })
 }
 

//applicatin load balancer
variable "alb" {
  type = object({
    name =  string
    load_balancer_type = string
    internal = bool
  })
}
variable "alb_tags" {
  type = string
}
//application lb target group
variable "application_lb_tg" {
  type = object({
    name = string
    port = number
    protocol = string
  })
}

// application tg attachment
variable "app_lb_tg_port" {
  type = number
}

// iam role
variable "s3_role" {
  type = object({
    name = string
  })
}
variable "tag-key" {
  type = string
}

//instance_profile
variable "iam_instanc_profile_name" {
  type = string
}

// iam_role_policy
variable "iam_role_policy_name" {
  type = string
}


