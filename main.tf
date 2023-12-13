//vpc
resource "aws_vpc" "aws_3_tier_architecture" {
  cidr_block       = var.aws_vpc.cidr_block
  instance_tenancy = var.aws_vpc.instance_tenancy

  tags = {
    name = var.vpc_name
  }
}


//Subnet for vpc
resource "aws_subnet" "pub-sub-01" {
  vpc_id            = aws_vpc.aws_3_tier_architecture.id
  cidr_block        = var.pub_subnet.pub_1_cidr
  availability_zone = var.pub_subnet.pub_1_az

  tags = {
    Name = var.sub_name_pub_1
  }
}
resource "aws_subnet" "pub-sub-02" {
  vpc_id            = aws_vpc.aws_3_tier_architecture.id
  cidr_block        = var.pub_subnet.pub_2_cidr
  availability_zone = var.pub_subnet.pub_2_az

  tags = {
    Name = var.sub_name_pub_2
  }
}
resource "aws_subnet" "pri-sub-01" {
  vpc_id            = aws_vpc.aws_3_tier_architecture.id
  cidr_block        = var.pri_subnet.pri_1_cidr
  availability_zone = var.pri_subnet.pri_1_az


  tags = {
    Name = var.sub_name_pri_1
  }
}
resource "aws_subnet" "pri-sub-02" {
  vpc_id            = aws_vpc.aws_3_tier_architecture.id
  cidr_block        = var.pri_subnet.pri_2_cidr
  availability_zone = var.pri_subnet.pri_2_az


  tags = {
    Name = var.sub_name_pri_2
  }
}





#Internet_internet_geteway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_3_tier_architecture.id
  tags = {
    Name = var.ig_name
  }
}


#EIP
resource "aws_eip" "eip" {
  #instance = aws_instance.web.id
  domain = var.eip_domain
}


#NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub-sub-01.id

  tags = {
    Name = var.nat_ig_name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
#Public rout-table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.aws_3_tier_architecture.id

  route {
    cidr_block = var.route_table.cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.public_route_name
  }
}
#public subnet-assosiation
resource "aws_route_table_association" "pub_subnet_01" {
  subnet_id      = aws_subnet.pub-sub-01.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "pub_subnet_02" {
  subnet_id      = aws_subnet.pub-sub-02.id
  route_table_id = aws_route_table.public.id
}
#private route-table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.aws_3_tier_architecture.id

  route {
    cidr_block = var.route_table.cidr_block
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = var.private_route_name
  }
}



#private subnet-assosiation
resource "aws_route_table_association" "pri_subnet_01" {
  subnet_id      = aws_subnet.pri-sub-01.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "pri_subnet_02" {
  subnet_id      = aws_subnet.pri-sub-02.id
  route_table_id = aws_route_table.private.id
}
//security_group
resource "aws_security_group" "web_sg" {
  name        = var.web_security_group.name
  description = var.web_security_group.description
  vpc_id      = aws_vpc.aws_3_tier_architecture.id

  ingress {
    description = var.web_sg_ingress.description_1
    from_port   = var.web_sg_ingress.from_port_1
    to_port     = var.web_sg_ingress.to_port_1
    protocol    = var.web_sg_ingress.protocol
    cidr_blocks = [var.web_sg_ingress.cidr_blocks]
  }
  ingress {
    description = var.web_sg_ingress.description_2
    from_port   = var.web_sg_ingress.from_port_2
    to_port     = var.web_sg_ingress.to_port_2
    protocol    = var.web_sg_ingress.protocol
    cidr_blocks = [var.web_sg_ingress.cidr_blocks]

  }
  ingress {
    description = var.web_sg_ingress.description_3
    from_port   = var.web_sg_ingress.from_port_3
    to_port     = var.web_sg_ingress.to_port_3
    protocol    = var.web_sg_ingress.protocol
    cidr_blocks = [var.web_sg_ingress.cidr_blocks]

  }
  egress {
    from_port   = var.sg_egress.from_port
    to_port     = var.sg_egress.to_port
    protocol    = var.sg_egress.protocol
    cidr_blocks = [var.sg_egress.cidr_blocks]

  }
}

resource "aws_security_group" "app_sg" {
  name        = var.app_security_group.name
  description = var.app_security_group.description
  vpc_id      = aws_vpc.aws_3_tier_architecture.id

  ingress {
    description = var.app_sg_ingress.description_1
    from_port   = var.app_sg_ingress.from_port_1
    to_port     = var.app_sg_ingress.to_port_1
    protocol    = var.app_sg_ingress.protocol
    cidr_blocks = [aws_subnet.pub-sub-01.cidr_block]

  }
  ingress {
    description = var.app_sg_ingress.description_2
    from_port   = var.app_sg_ingress.from_port_2
    to_port     = var.app_sg_ingress.to_port_2
    protocol    = var.app_sg_ingress.protocol
    cidr_blocks = [aws_subnet.pri-sub-02.cidr_block]

  }
  ingress {
    description = var.app_sg_ingress.description_3
    from_port   = var.app_sg_ingress.from_port_3
    to_port     = var.app_sg_ingress.to_port_3
    protocol    = var.app_sg_ingress.protocol
    cidr_blocks = [aws_subnet.pri-sub-02.cidr_block]

  }
  egress {
    from_port   = var.sg_egress.from_port
    to_port     = var.sg_egress.to_port
    protocol    = var.sg_egress.protocol
    cidr_blocks = [var.sg_egress.cidr_blocks]

  }
}
resource "aws_key_pair" "deployer" {
  key_name   = var.aws_key_pair.key_name
  public_key = var.aws_key_pair.public_key
  }


#web_instance

resource "aws_instance" "web_instance" {
  ami                         = var.web_instance.ami
  instance_type               = var.web_instance.instance_type
  associate_public_ip_address = var.web_instance.associate_public_ip_address
  key_name                    = aws_key_pair.deployer.key_name
  security_groups             = [aws_security_group.web_sg.id]
  subnet_id                   = aws_subnet.pub-sub-01.id
  iam_instance_profile        = aws_iam_instance_profile.test.name

  tags = {
    Name = var.web_tags
  }
}

//app_instance
resource "aws_instance" "app_instance" {
  ami                  = var.app_instance.ami
  instance_type        = var.app_instance.instance_type
  key_name             = aws_key_pair.deployer.key_name
  security_groups      = [aws_security_group.app_sg.id]
  subnet_id            = aws_subnet.pri-sub-01.id
  iam_instance_profile = aws_iam_instance_profile.test.name
  tags = {
    Name = var.app_tags
  }
}

//rds_security_group
resource "aws_security_group" "db_security_group" {
  name        = var.rds_sg.name
  description = var.rds_sg.description
  vpc_id      = aws_vpc.aws_3_tier_architecture.id

  ingress {
    description = var.rds_sg_ingress.description
    from_port   = var.rds_sg_ingress.from_port
    to_port     = var.rds_sg_ingress.to_port
    protocol    = var.rds_sg_ingress.protocol
    cidr_blocks = [aws_subnet.pri-sub-01.cidr_block]

  }
  egress {
    from_port   = var.sg_egress.from_port
    to_port     = var.sg_egress.to_port
    protocol    = var.sg_egress.protocol
    cidr_blocks = [var.sg_egress.cidr_blocks]

  }
}
//creating rds
resource "aws_db_subnet_group" "my_database_subnet_group" {
  name       = var.rds_subnet_group.name
  subnet_ids = [aws_subnet.pri-sub-01.id, aws_subnet.pri-sub-02.id]
  tags = {
    Name   = var.rds_subnet_group_tags
    vpc_id = aws_vpc.aws_3_tier_architecture.id
  }
}
resource "aws_db_instance" "aws_3_tier_database" {
  allocated_storage      = var.aws_db_instance.allocated_storage
  db_name                = var.aws_db_instance.db_name
  engine                 = var.aws_db_instance.engine
  engine_version         = var.aws_db_instance.engine_version
  db_subnet_group_name   = aws_db_subnet_group.my_database_subnet_group.id
  instance_class         = var.aws_db_instance.instance_class
  username               = var.aws_db_instance.username
  password               = var.aws_db_instance.password
  parameter_group_name   = var.aws_db_instance.parameter_group_name
  skip_final_snapshot    = var.aws_db_instance.skip_final_snapshot

  vpc_security_group_ids = [aws_security_group.db_security_group.id, aws_security_group.app_sg.id]

}
//s3_bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket
  tags = {
    Name        = var.bucket_name
    Environment = var.env
  }
}

//application_load_balancer_sg
resource "aws_security_group" "app_lb_sg" {
  name        = var.application_lb_sg.name
  description = var.application_lb_sg.description
  vpc_id      = aws_vpc.aws_3_tier_architecture.id

  ingress {
    description = var.app_lb_ingress.description
    from_port   = var.app_lb_ingress.from_port
    to_port     = var.app_lb_ingress.to_port
    protocol    = var.app_lb_ingress.protocol
    cidr_blocks = [var.app_lb_ingress.cidr_blocks]

  }
  egress {
    from_port   = var.app_lb_egress.from_port
    to_port     = var.app_lb_egress.to_port
    protocol    = var.app_lb_egress.protocol
    cidr_blocks = [aws_subnet.pub-sub-02.cidr_block]
  }

}
//Aplication Load balancer
resource "aws_lb" "alb_01" {
  name               = var.alb.name
  internal           = var.alb.internal
  load_balancer_type = var.alb.load_balancer_type
  security_groups    = [aws_security_group.app_lb_sg.id]
  subnets            = [aws_subnet.pri-sub-01.id, aws_subnet.pri-sub-02.id]
  tags = {
    Environment = var.alb_tags
  }
}
resource "aws_lb_target_group" "app_lb_tg" {
  name     = var.application_lb_tg.name
  port     = var.application_lb_tg.port
  protocol = var.application_lb_tg.protocol
  vpc_id   = aws_vpc.aws_3_tier_architecture.id
}

resource "aws_lb_target_group_attachment" "web_tg" {
  target_group_arn = aws_lb_target_group.app_lb_tg.id
  target_id        = aws_instance.web_instance.id
  port             = var.app_lb_tg_port
}


//iam role
resource "aws_iam_role" "s3_access_role" {
  name = var.s3_role.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = var.tag-key
  }
}
resource "aws_iam_instance_profile" "test" {
  name = "s3_access_role"
  role = aws_iam_role.s3_access_role.id
}
resource "aws_iam_role_policy" "s3_access_policy" {
  name = "s3_access_policy"
  role = aws_iam_role.s3_access_role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}
