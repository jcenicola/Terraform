# scale up alarm

resource "aws_autoscaling_policy" "jc-test-cpu-policy" {
  name                   = "jc-test-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.test-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "jc-test-cpu-alarm" {
  alarm_name          = "jc-test-cpu-alarm"
  alarm_description   = "jc-test-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.test-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.jc-test-cpu-policy.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "jc-test-cpu-policy-scaledown" {
  name                   = "jc-test-cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.test-autoscaling.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "jc-test-cpu-alarm-scaledown" {
  alarm_name          = "jc-test-cpu-alarm-scaledown"
  alarm_description   = "jc-test-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.test-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.jc-test-cpu-policy-scaledown.arn}"]
}
