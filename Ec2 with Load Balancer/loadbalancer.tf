resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Security group for Load Balancer"
  vpc_id      = aws_vpc.lb_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "lb_sg"
  }
}

resource "aws_lb" "Load_Balancer" {
  name               = "Load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.lb_subnet-1.id, aws_subnet.lb_subnet-2.id]

  tags = {
    Name = "load_balancer"
  }

}

resource "aws_lb_target_group" "Lb_target_group" {
  name     = "Lb-Target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lb_vpc.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200-399"
  }

  tags = {
    Name = "lb_target_group"
  }

}

resource "aws_lb_target_group_attachment" "lb-tg-attachment-1" {
  target_group_arn = aws_lb_target_group.Lb_target_group.arn
  target_id        = aws_instance.lb-instance-1.id
  port             = 80

}
resource "aws_lb_target_group_attachment" "lb-tg-attachment-2" {
  target_group_arn = aws_lb_target_group.Lb_target_group.arn
  target_id        = aws_instance.lb-instance-2.id
  port             = 80

}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.Load_Balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Lb_target_group.arn
  }
}

resource "aws_route_table_association" "lb-rta1" {
  subnet_id      = aws_subnet.lb_subnet-1.id
  route_table_id = aws_route_table.lb_route_table.id
}
resource "aws_route_table_association" "lb-rta2" {
  subnet_id      = aws_subnet.lb_subnet-2.id
  route_table_id = aws_route_table.lb_route_table.id
}
