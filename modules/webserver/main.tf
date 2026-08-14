resource "aws_security_group" "myapp-security-group" {
  name   = "${var.env_prefix}-myapp-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name : "${var.env_prefix}-myapp-security-group"
  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_image_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "server-key" {
  key_name   = "${var.env_prefix}-server-key"
  public_key = file(var.public_key_path)
  tags = {
    Name : "${var.env_prefix}-server-key"
  }
}

resource "aws_instance" "myapp-server" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.instance_type
  availability_zone           = var.avail_zone
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.myapp-security-group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.server-key.key_name
  user_data                   = file("./modules/webserver/entry-script.sh")
  user_data_replace_on_change = true
  tags = {
    Name : "${var.env_prefix}-myapp-server"
  }
}
