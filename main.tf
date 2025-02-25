terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-029f33a91738d30e9"
  instance_type = "t2.micro"

  key_name = "instancia_alura"

  user_data = <<-EOF
                 #!/bin/bash
                 cd /home/ubuntu/
                 echo "<h1>Nova Instancia AWS/Terraform</h1>" > index.html
                 nohup busybox httpd -f -p 8080 &
                 EOF
  tags = {
    Name = "srv_ubtn_aws"
  }
}

output "instance_id" {
  value = aws_instance.app_server.id
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}
