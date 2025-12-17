resource "aws_vpc" "lb_vpc" {
  cidr_block = var.lb_vpc_cidr
  tags = {
    Name = "lb_vpc"
  }
}

resource "aws_subnet" "lb_subnet-1" {
  vpc_id                  = aws_vpc.lb_vpc.id
  cidr_block              = var.lb_subnet1
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-1"
  }

}
resource "aws_subnet" "lb_subnet-2" {
  vpc_id                  = aws_vpc.lb_vpc.id
  cidr_block              = var.lb_subnet2
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    name = "subnet-2"
  }
}

resource "aws_route_table" "lb_route_table" {
  vpc_id = aws_vpc.lb_vpc.id

  tags = {
    Name = "lb_route_table"
  }

}
resource "aws_route" "lb_route_table" {
  route_table_id         = aws_route_table.lb_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lb_igw.id
}

resource "aws_internet_gateway" "lb_igw" {
  vpc_id = aws_vpc.lb_vpc.id

  tags = {
    Name = "lb_internet_gateway"
  }
}

resource "aws_security_group" "Lb-Instance-Sg" {
  name        = "lb_Instance_Sg"
  description = "Security group for Load Balancer"
  vpc_id      = aws_vpc.lb_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
  tags = {
    Name = "lb_Instance_Sg"
  }
}

resource "aws_instance" "lb-instance-1" {
  ami             = var.lb_ami # Amazon Linux 2 AMI
  instance_type   = var.lb_instance_type
  subnet_id       = aws_subnet.lb_subnet-1.id
  security_groups = [aws_security_group.Lb-Instance-Sg.id]
  key_name        = "demo-key"

  tags = {
    Name = "Instance-1"
  }

  user_data = file("userdata-1.sh")

}

resource "aws_instance" "lb-instance-2" {
  ami             = var.lb_ami # Amazon Linux 2 AMI
  instance_type   = var.lb_instance_type
  subnet_id       = aws_subnet.lb_subnet-2.id
  security_groups = [aws_security_group.Lb-Instance-Sg.id]
  key_name        = "demo-key"
  tags = {
    Name = "Instance-2"
  }
  user_data = file("userdata-2.sh")
}

resource "aws_route_table_association" "rt-ass-sub1" {
  subnet_id      = aws_subnet.lb_subnet-1.id
  route_table_id = aws_route_table.lb_route_table.id

}

resource "aws_route_table_association" "rt-ass-sub2" {
  subnet_id      = aws_subnet.lb_subnet-2.id
  route_table_id = aws_route_table.lb_route_table.id
}