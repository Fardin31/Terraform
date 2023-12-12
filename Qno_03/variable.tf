variable "cidr_block" {
  type = list(any)
}
variable "availability_zone" {
  type = list(any)
}
variable "tags" {
  type = list(any)
}
variable "domain" {
  type = string
}
variable "instance_tenancy" {
  type = string
}