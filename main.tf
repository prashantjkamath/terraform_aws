provider "aws" {
  region = "us-east-2"
}

################## VPC Block ###################

resource "aws_vpc" "pjk_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "pjk_vpc"

  }
}

################## Internet Gateway #############

resource "aws_internet_gateway" "pjk_igw" {
  vpc_id = aws_vpc.pjk_vpc.id

  tags = {
    Name = "pjk_igw"
  }
}


################## subnet ###########################

resource "aws_subnet" "pjk_subnet" {
  vpc_id     = aws_vpc.pjk_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "pjk_subnet"
  }
}

################# Route Table ########################

resource "aws_route_table" "pjk_route_table" {
  vpc_id = aws_vpc.pjk_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pjk_igw.id
  }

  tags = {
    Name = "pjk_route"
  }
}

#################### Route ###################################
#
#resource "aws_route" "r" {
#  route_table_id            = aws_route_table.pjk_route_table.id
#  destination_cidr_block    = "0.0.0.0/0"
#  gateway_id = aws_internet_gateway.pjk_igw.id
#  depends_on                = [aws_route_table.pjk_route_table]                      #To create the route after route table created#

################### Securty Group ##############################

resource "aws_security_group" "pjk_sg" {
  name        = "pjk_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.pjk_vpc.id

  ingress {
    description      = "All Traffic"
    from_port        = 0
    to_port          = 0    # All Ports #
    protocol         = "-1" # All Traffic #
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "pjk_sg"
  }
}

##################### Route Table Association ############################

resource "aws_route_table_association" "pjk_route_table_association" {
  subnet_id      = aws_subnet.pjk_subnet.id
  route_table_id = aws_route_table.pjk_route_table.id
}

#################### EC2 instance #####################################

resource "aws_instance" "pjk_instance" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pjk_subnet.id

  tags = {
    Name = "pjk_instance"
  }
}



###################### Creation of S3 Bucket additionally ##################

resource "aws_s3_bucket" "pjkbucket-6789" {
  bucket = "pjkbucket-6789"

  tags = {
    Name        = "pjkbucket-6789"
  }
}
