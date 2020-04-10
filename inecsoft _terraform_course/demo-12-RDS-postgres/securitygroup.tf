resource "aws_security_group" "example-instance" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "allow-ssh"
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
  tags = {
    Name = "example-instance"
  }

}
#-------------------------------------------------------------------------------------
#create security group for the RDS server
#apply security_groups to allow access to RDS from other servers
#-------------------------------------------------------------------------------------
resource "aws_security_group" "allow-postgresdb" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "allow-postgresdb"
  description = "allow-postgresdb"
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }
  ingress {
    from_port = 5432
    protocol = "tcp"
    to_port = 5432
    security_groups =[aws_security_group.example-instance.id] # allowing access from our example instance
  }
  tags = {
    Name = "allow-postgresdb"
  }

}