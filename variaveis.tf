variable "amis" {
  type        = map
  default     = {
      "us-east-1" = "ami-026c8acd92718196b"
      "us-east-2" = "ami-0b614a5d911900a9b"
  }  
}

variable "cdirs_acesso_remoto" {
  type        = list
  default     = ["45.181.144.210/32"]
}

variable "key_name" {
  type        = string
  default     = "terraform-aws"
  
}
