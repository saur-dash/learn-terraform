provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

module "my-app-subnet" {
  source            = "./modules/subnet"
  avail_zone        = var.avail_zone
  env_prefix        = var.env_prefix
  subnet_cidr_block = var.subnet_cidr_block
  vpc_id            = aws_vpc.myapp-vpc.id
}

module "my-app-server" {
  source            = "./modules/webserver"
  ami_image_pattern = var.ami_image_pattern
  avail_zone        = var.avail_zone
  env_prefix        = var.env_prefix
  instance_type     = var.instance_type
  my_ip             = var.my_ip
  public_key_path   = var.public_key_path
  subnet_id         = module.my-app-subnet.subnet.id
  vpc_id            = aws_vpc.myapp-vpc.id
}
