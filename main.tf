provider "aws" {
  region = "ap-south-1"
  access_key = ""
  secret_key = ""
}


resource "aws_db_instance" "default" {  
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  #name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  
}

resource "aws_s3_bucket" "bucket1" {
    bucket="my-tf-buckettt"

    tags= {
        Name="my bucket"
        Environment ="Dev"
    }
  
}

resource "aws_s3_bucket_acl" "example" {
    bucket=aws_s3_bucket.bucket1.id
    acl= "private"  
  
}


### Security Group 


resource "aws_security_group" "allow_tls" {
  name        = "allow_tlsss"
  description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
     cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    # cidr_blocks      = [aws_vpc.main.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

