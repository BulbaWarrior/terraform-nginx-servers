terraform {
  backend "s3" {
    bucket  = "vlados-chum-bucket"
    key     = "global/s3/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "vlados-chum-bucket"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "VladOS_VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mygateway"
  }
}

resource "aws_default_route_table" "main_route_table" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_security_group" "all_tcp_v4" {
  vpc_id = aws_vpc.main.id
  name   = "very welcoming group"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                         = "ami-01e7ca2ef94a0ae86"
  key_name                    = "us-east-2_vlad"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.all_tcp_v4.id]
  associate_public_ip_address = true
  count                       = 2
  tags = {
    Name = var.instance_name
  }

  provisioner "remote-exec" {
    inline = ["sudo apt install -y python3"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_key_private)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "yes | ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ssh_key_private} ansible/playbook.yml"
  }
}
