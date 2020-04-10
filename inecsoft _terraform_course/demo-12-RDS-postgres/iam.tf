
##################################################
# Create an IAM role to allow enhanced monitoring
##################################################
resource "aws_iam_role" "rds_enhanced_monitoring_db" {
  name_prefix = "rds_enhanced_monitoring_db"
  assume_role_policy = data.aws_iam_poicy_document.rds_enhanced_monitoring.json
}

resource "aws_iam_policy_attachment" "rds_enhanced_monitoring_db" {
  name = aws_iam_role.rds_enhanced_monitoring_db.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"

    principals {
      identifiers = ["monitoring.rds.amazonaws.com"]
      type = "Service"
    }

  }
}