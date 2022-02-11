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

// Criando acesso ao dev06 na us-east-2
provider "aws" {
  alias = "us-east-2"
  region  = "us-east-2"
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
resource "aws_instance" "dev4" {
  ami = "ami-026c8acd92718196b"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev4"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
  depends_on = ["aws_s3_bucket.dev4"]
}

resource "aws_instance" "dev5" {
  ami = "ami-026c8acd92718196b"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev5"
  }
   vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}


resource "aws_instance" "dev6" {
  provider = "aws.us-east-2"
  ami = "ami-0b614a5d911900a9b"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev6"
  }
   vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
   depends_on = ["aws_dynamodb_table.dynamodb-homologacao"]
}

resource "aws_s3_bucket" "dev4" {
  bucket = "rivas-dev4"
  acl    = "private"

  tags = {
    Name = "rivas-dev4"
  }
}

// criando DataBase
resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = " aws.us-east-2"
  name           = "GameScores"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}



