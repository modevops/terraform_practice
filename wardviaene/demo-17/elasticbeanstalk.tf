resource "aws_elastic_beanstalk_application" "app" {
  name = "app"
  description = "app"
}


resource "aws_elastic_beanstalk_environment" "app-pro" {
  application = "aws_elastic_beanstalk_application.app.name"
  name = "app-prod"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.9.2 running PHP 7.2"
  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = aws_vpc.main.id
  }
  setting {
    name = "Subnets"
    namespace = "aws:ec2:vpc"
    value = "${aws_subnet.main-private-1.id},${aws_subnet.main-private-2.id}"
  }
  setting {
    name = "AssociatePublicIpAddress"
    namespace = "aws:ec2:vpc"
    value = "false"
  }
  setting {
    name = "IAMInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value = "aws_iam_instance_profile.app-ec2-role.name"
  }
  setting {
    name = "SecurityGroups"
    namespace = "aws:autoscaling:launchconfiguration"
    value = "aws_security_group.app-prod.id"
  }
  setting {
    name = "EC2KeyName"
    namespace = "aws:autoscaling:launchconfiguration"
    value = "aws_key_pair.mykeypair.id"
  }
  setting {
    name = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration"
    value = "t2.micro"
  }
  setting {
    name = "ServiceRole"
    namespace = "aws:elasticbeanstalk:environment"
    value = aws_iam_role.elasticbeanstalk-service-role.name
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = "${aws_subnet.main-public-1.id},${aws_subnet.main-public-2.id}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "30"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Percentage"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 2"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_USERNAME"
    value     = aws_db_instance.mariadb.username
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PASSWORD"
    value     = aws_db_instance.mariadb.password
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_DATABASE"
    value     = aws_db_instance.mariadb.name
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_HOSTNAME"
    value     = aws_db_instance.mariadb.endpoint
  }
}

