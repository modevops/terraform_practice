resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-a4654654654"
  acl = "private"

  tags {
    Name = "Terraform State"
  }
}