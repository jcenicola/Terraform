resource "aws_launch_configuration" "test-launchconfig" {
  name_prefix          = "test-launchconfig"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  security_groups      = ["${aws_security_group.allow-ssh.id}"]
  }

resource "aws_autoscaling_group" "test-autoscaling" {
  name                 = "test-autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.jc_vpc_public-1.id}"]
  launch_configuration = "${aws_launch_configuration.test-launchconfig.name}"
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true

  tag {
      key = "JC-ASG1"
      value = "ec2 instance"
      propagate_at_launch = true
  }
}
