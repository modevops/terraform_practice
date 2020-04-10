resource "aws_security_group" "app-prod" {
  vpc_id = aws_vpc.main.id
  name   = "application - production"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
     from_port = 22
     protocol = "tcp"
     to_port = 22
     cidr_blocks = ["0.0.0.0/0"]
   }

  tags {
    Name = "myinstance"
  }
}


resource "aws_security_group" "allow-mariadb" {
  vpc_id = aws_vpc.main.id
  name        = "allow-mariadb"
  description = "allow-mariadb"
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    security_groups = [aws_security_group.example-instance.id] # allowing access from our example instance
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  tags = {
    Name = "allow-mariadb"
  }

}