aws_vpc = {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
}

vpc_name = "AWS_3_TIER_ACHITECTURE_VPC"


pub_subnet = {
    pub_1_cidr = "10.0.0.0/18"
    pub_1_az = "ap-south-1a"
    pub_2_cidr ="10.0.64.0/18"
    pub_2_az = "ap-south-1b"
}

pri_subnet = {
  pri_1_cidr = "10.0.128.0/18"
  pri_1_az = "ap-south-1b"
  pri_2_cidr = "10.0.192.0/18"
  pri_2_az = "ap-south-1a"
}

sub_name_pri_1 = "PRIVATE_SUBNET_01"
sub_name_pri_2 = "PRIVATE_SUBNET_02"
sub_name_pub_1 = "PUBLIC_SUBNET_01"
sub_name_pub_2 = "PUBLIC_SUBNET_02"

ig_name = "3_TIER_INTERNET_GATEWAY"
eip_domain = "vpc"
nat_ig_name = "3_TIER_NAT_GATEWAY"

route_table = {
  cidr_block = "0.0.0.0/0"
}

public_route_name = "public"
private_route_name = "private"


//web_security_group
web_security_group = {
  name = "WEB_SECURITY_GROUP"
  description = "Allow ssh & http inbound traffic"
}

web_sg_ingress = {
  cidr_blocks = "0.0.0.0/0"
  description_1 = "https"
  description_2 = "http"
  description_3 = "ssh"
  from_port_1 = 443
  from_port_2 = 80
  from_port_3 = 22
  to_port_1 = 443
  to_port_2 = 80
  to_port_3 = 22
  protocol = "tcp"
}
app_security_group = {
    name        = "APPLICATION_SECURITY_GROUP"
    description = "ALLOW SSH"
}

 app_sg_ingress = {
  description_1 = "ssh"
  description_2 = "http"
  description_3 = "my_sql"
  from_port_1 = 22
  from_port_2 = 80
  from_port_3 = 3306
  to_port_1 = 22
  to_port_2 = 80
  to_port_3 = 3306
  protocol = "tcp"
  }

sg_egress = {
  cidr_blocks = "0.0.0.0/0"
  from_port = 0
  to_port = 0
  protocol = "-1"
}
//key_par
aws_key_pair ={
    key_name = "fardin12.pem"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsNCYm3sQEJmJvy0sW0TrkFY1MEXeqrBhS5npqRdYkvfeyn59eW6adCTradoD0eYaWCaqSsgDim8F/bNlP7Kx1lGCIaA8Hrci1Jizxyg/UAT8p9IRY9DzkrhsYAejc4uNkPT44SehTl6ku08wyas8l7atOGi6lRjcBNvn1cbsFXE/wk+dl1nSL0JMY3BaR0zwFDUkA+klrPfFqXBRsXLrVsBXSxYnBuVVLrUfWHkNHDl+isID5icrekRCJqsrVUqYE49LNji3tQ6TzagJWaV37Zycg5zzzaKXqZ4AkEXFEocJvuiAXaLRWDCov6EFAQrbHeWIZ3cfsSmxJcNAX0mLjnBXrY7XO2eJyaz4ebzpy3O69pXLJWNTkUkvB0DY4RNqzbapg5TDWjTpRFx1+sKpcLxd/no3wlhbF+TMjM+TsICG04XDe2zzlOPeKbhtyeuK1h17xibchugF8jEJ6UVg0Wse5xDUxc4vvSYZ2flAKVkyukXcznQIXr8KIHwQjUz8= root@FARDIN"
}
//web_instance
web_instance = {
  ami = "ami-02a2af70a66af6dfb"
  instance_type = "t2.micro"
  associate_public_ip_address = true
}
web_tags = "WEB_INSTANCE"
//app_instance
app_instance = {
  ami =  "ami-02a2af70a66af6dfb"
  instance_type = "t2.micro"
}
app_tags = "APPLICATION_INSTANCE"
rds_sg = {
  description = "ALLOW MYSQL"
  name = "DB_SECURITY_GROUP"
}
//rds
rds_sg_ingress = {
  description = "mysql"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
}
rds_subnet_group = {
  name = "my-database-subnet-group"
}
rds_subnet_group_tags = "MY_DATABASE_SUBNET_GROUP"
aws_db_instance = {
  allocated_storage = 10
  db_name = "aws_3_tier_database"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  username = "root"
  parameter_group_name = "default.mysql5.7"
  password = "fardin123"
  skip_final_snapshot = true
}
//bucket 
bucket = "my-aws-bucket-898989"
bucket_name = "my-aws-bucket-898989"
env = "Dev"

//application_load_balancer_sg
application_lb_sg = {
  description = "ALLOW HTTPS"
  name = "app_lb_sg"
}
app_lb_ingress = {
  description = "https"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = "0.0.0.0/0"
}
app_lb_egress = {
  from_port = 80
  to_port = 80
  protocol = "tcp"
}

//application Load balancer
alb = {
  name = "application-load-balancer"
  load_balancer_type = "application"
  internal = false
}
alb_tags = "working"

//application lb target group

application_lb_tg = {
  name = "app-lb-tg"
  port = 80
  protocol = "HTTP"
}
app_lb_tg_port = 443
// iam role
s3_role = {
  name = "s3_access_role"
}
tag-key = "AmazonS3FullAccess"

//iam_instance_profile
iam_instanc_profile_name = "s3_access_role"

//iam_role_policy
iam_role_policy_name = "s3_access_role"
