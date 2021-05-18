provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_launch_configuration" "web" {
  name_prefix     = "Web-servers_LaunchConfigs-"
  image_id        = data.aws_ami.latest_amazon_linux.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ForWebServer.id]
  user_data       = file("user_data.sh")
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "My_Scaling_Group" {
  name                 = "ASG-${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  vpc_zone_identifier  = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.Load_Balancer.name]

  tags = [
    {
      key                 = "Name"
      value               = "Web_Server_in_ASG"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}
