//user

resource "aws_iam_user" "iam_user" {
  name = var.uname
  tags = {
    tag-key = var.tags
  }
}
//group
resource "aws_iam_group" "iam_group" {
  name = var.gname
 
}