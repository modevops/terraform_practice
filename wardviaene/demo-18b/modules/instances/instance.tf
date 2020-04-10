data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



resource "aws_instance" "instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.keyname

  tags = {
    Name         = "instance-${var.ENV}"
    Environmnent = var.ENV
  }


}

resource "aws_key_pair" "mykeypair" {
  key_name = "mykeypair-${ENV}}"
  public_key = file("${path.root}/${var.PATH_TO_PUBLIC_KEY}}")
}