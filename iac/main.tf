provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_id" {
  description = "Subnet ID"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" // Ubuntu 20.04 LTS
  instance_type = "t2.micro"
  key_name      = "epam.pem"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.instance.id]
  associate_public_ip_address = true

  tags = {
    NAME  = "epam-ai"
    owner = "demian"
    app   = "epam-ai"
  }
}

resource "aws_security_group" "instance" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}