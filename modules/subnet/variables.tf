variable "avail_zone" {
  description = "AWS availability zone to deploy infrastructure to"
  type        = string
}
variable "env_prefix" {
  description = "Environment prefix to apply to resource names"
  type        = string
}
variable "subnet_cidr_block" {
  description = "IP address range to assign to subnet"
  type        = string
}
variable "vpc_id" {
  description = "Unique ID of the VPC"
  type        = string
}
