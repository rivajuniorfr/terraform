terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

provider "aws" {

  region  = "us-east-1"
}

resource "aws_instance" "dev" {
    count = 3
    ami = "ami-0b0ea68c435eb488d"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
       Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["45.181.144.210/32"]
  }
  tags = {
    Name = "ssh"
  }
}



