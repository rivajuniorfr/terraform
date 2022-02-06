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
}



