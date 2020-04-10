resource "aws_s3_bucket" "b" {
  bucket = "mybucket-modevops-bucket-test1"
  acl    = "private"

  tags = {
    Name = "mybucket-modevops-bucket-test1"
  }

}