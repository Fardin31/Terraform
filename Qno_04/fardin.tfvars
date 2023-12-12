cidr_block        = ["10.0.0.0/16", "10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/18", "10.0.192.0/18", "0.0.0.0/0"]
instance_tenancy  = "default"
availability_zone = ["ap-south-1a", "ap-south-1b"]
tags              = ["my_vpc", "public-sub-01", "public-sub-02", "private-sub-01", "private-sub-02", "igw", "nat_gw", "public", "private", "allow_ssh", "aws_instance"]
domain            = "vpc"
key_name          = "fardin12.pem"
public_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsNCYm3sQEJmJvy0sW0TrkFY1MEXeqrBhS5npqRdYkvfeyn59eW6adCTradoD0eYaWCaqSsgDim8F/bNlP7Kx1lGCIaA8Hrci1Jizxyg/UAT8p9IRY9DzkrhsYAejc4uNkPT44SehTl6ku08wyas8l7atOGi6lRjcBNvn1cbsFXE/wk+dl1nSL0JMY3BaR0zwFDUkA+klrPfFqXBRsXLrVsBXSxYnBuVVLrUfWHkNHDl+isID5icrekRCJqsrVUqYE49LNji3tQ6TzagJWaV37Zycg5zzzaKXqZ4AkEXFEocJvuiAXaLRWDCov6EFAQrbHeWIZ3cfsSmxJcNAX0mLjnBXrY7XO2eJyaz4ebzpy3O69pXLJWNTkUkvB0DY4RNqzbapg5TDWjTpRFx1+sKpcLxd/no3wlhbF+TMjM+TsICG04XDe2zzlOPeKbhtyeuK1h17xibchugF8jEJ6UVg0Wse5xDUxc4vvSYZ2flAKVkyukXcznQIXr8KIHwQjUz8= root@FARDIN"
name              = "allow_ssh"
description       = ["Allow TLS inbound traffic", "ssh"]
protocol          = ["tcp", "-1"]
ami               = "ami-02a2af70a66af6dfb"
instance_type     = "t2.micro"


