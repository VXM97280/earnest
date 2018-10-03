# ------------------------------------
# test-earnest-ec2 launch configuration
# -------------------------------------
resource "aws_launch_configuration" "test_earnest_ec2_lc" {
  name                 = "${var.tag_environment}-${var.tag_name}-ec2"
  image_id             = "${var.ubuntu_ami_id}"
  instance_type        = "${var.ec2_instance_type}"
 // iam_instance_profile = "${aws_iam_instance_profile.test_earnest_profile.name}" # NEED TO CHANGE
  user_data            = "{\"autoScalingGroup\": \"${var.tag_environment}-${var.tag_name}\"}"
  key_name             = "devopslook" # NEED TO CHANGE

  root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    },
  ]

  # security_groups = [
  #   "${aws_security_group.test_earnest_management.id}", # NEED TO CHANGE
  #   "${aws_security_group.test_earnest_asg_sg.id}", # NEED TO CHANGE
  # ]
}

# ------------------------------------
# test-earnest-asg auto scalling group
# -------------------------------------
resource "aws_autoscaling_group" "test_earnest_asg" {
  name                = "${var.tag_environment}-${var.tag_name}-asg"
  vpc_zone_identifier = ["${aws_subnet.private_az1.id}","${aws_subnet.private_az2.id}","${aws_subnet.private_az3.id}"]

  load_balancers       = ["${aws_elb.test_earnest_elb.name}"]
  termination_policies = ["OldestLaunchConfiguration", "OldestInstance"]

  min_size                  = 1
  max_size                  = 1
  wait_for_capacity_timeout = 0

  launch_configuration      = "${aws_launch_configuration.test_earnest_ec2_lc.name}"
  enabled_metrics           = ["GroupInServiceInstances", "GroupTerminatingInstances", "GroupPendingInstances", "GroupDesiredCapacity", "GroupStandbyInstances", "GroupMinSize", "GroupMaxSize", "GroupTotalInstances"]
  health_check_type         = "EC2"

  tags = [
    {
      key                 = "Name"
      value               = "${var.tag_environment}-${var.tag_name}-asg"
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}

# ------------------------------------
# test-earnest-asg load balancers
# -------------------------------------
resource "aws_elb" "test_earnest_elb" {
  name               = "${var.tag_environment}-${var.tag_name}-lb"
  subnets = ["${aws_subnet.public_az1.id}","${aws_subnet.public_az2.id}","${aws_subnet.public_az3.id}"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # listener {
  #   instance_port      = 8000
  #   instance_protocol  = "http"
  #   lb_port            = 443
  #   lb_protocol        = "https"
  #   ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  # }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name            = "${var.tag_environment}-${var.tag_name}-lb"
    Terraform       = "true"
  }
}