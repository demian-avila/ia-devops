provider "aws" {
  region = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "key_pair_name" {
  description = "The name of the key pair to use for EC2 instance"
  type        = string
  default     = "epam.pem"
}

variable "tags" {
  description = "The tags to be applied to resources"
  type        = map(string)
  default     = {
    NAME  = "epam-ai"
    owner = "demian"
    app   = "epam-ai"
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = "us-east-1b"
}

resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-0c55b159cbfafe1f0" // Ubuntu Server 22.04 LTS
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_pair_name
  associate_public_ip_address = true
  tags                   = var.tags
}