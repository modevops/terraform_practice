resource "aws_security_group" "ecs-securitygroup" {
  vpc_id = aws_vpo.main.id
  name = "ecs"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3000
    protocol = "tcp"
    to_port = 3000
    security_groups = [aws_security_group.myapp-elb.securitygroup.id]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags {
    Name = "ecs"
  }

}


resource "aws_security_group" "myapp-elb-securitygroup" {
  vpc_id = aws_vpc.main.id
  name   = "myapp-elb"
  description = "security group for ecs"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "myapp-elb"
  }


}

