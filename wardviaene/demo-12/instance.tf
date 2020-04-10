resource "aws_instance" "example" {
  ami = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id




  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

}
