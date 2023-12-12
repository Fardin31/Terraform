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
variable "key_name" {
  type = string
}
variable "public_key" {
  type = string
}
variable "name" {
  type = string
}
variable "description" {
  type = list(any)
}
variable "protocol" {
  type = list(any)
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
