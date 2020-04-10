data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}


resource "aws_instance" "example" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = var.ENV == "prod" ? module.vpc-prod.public_subnets[0] : module.vp-dev.public_subnets[0]

  # the security group
  vpc_security_group_ids = [var.ENV == "prod" ? aws_security_group.allow-ssh-prod.id : aws_security_group.allow-ssh-dev]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}