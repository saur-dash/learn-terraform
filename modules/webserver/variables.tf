variable "ami_image_pattern" {
  description = "REGEX pattern to filter AWS AMI for EC2"
  type        = string
}
variable "avail_zone" {
  description = "AWS availability zone to deploy infrastructure to"
  type        = string
}
variable "env_prefix" {
  description = "Environment prefix to apply to resource names"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type to deploy"
  type        = string
}
variable "my_ip" {
  description = "IP address to allow SSH access to EC2 instance"
  type        = string
}
variable "public_key_path" {
  description = "Path to your RSA public key to allow SSH access to EC2 instance"
  type        = string
}
variable "subnet_id" {
  description = "Unique ID of the subnet"
  type        = string
}
variable "vpc_id" {
  description = "Unique ID of the VPC"
  type        = string
}
