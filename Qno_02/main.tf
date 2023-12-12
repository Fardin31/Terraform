//ec2-instance
resource "aws_instance" "my_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.tags
  }
}
//eip
resource "aws_eip" "my_eip" {
  instance = aws_instance.my_instance.id
  domain   =var.domain
}
//eip_mapping_to_ec2_instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.my_instance.id
  allocation_id = aws_eip.my_eip.id
}

