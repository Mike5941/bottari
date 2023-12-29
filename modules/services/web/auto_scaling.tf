resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.amazon_linux2.id  // Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "wonsoong"
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet[0]
  vpc_security_group_ids = [aws_security_group.bastion.id]


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Bastion Host"
  }
}


resource "aws_launch_configuration" "wordpress" {
  image_id        = data.aws_ami.amazon_linux2.id
  instance_type   = "t3.small"
  security_groups = [aws_security_group.wordpress.id]

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    db_host  = var.db_host
    db_port     = var.db_port
  }))

  lifecycle {
    create_before_destroy = true
  }
}

 resource "aws_autoscaling_group" "wordpress" {
   name                 = "${var.cluster_name}-${aws_launch_configuration.wordpress.name}"
   launch_configuration = aws_launch_configuration.wordpress.name
   vpc_zone_identifier  = data.terraform_remote_state.vpc.outputs.private_subnet

   target_group_arns = [aws_lb_target_group.asg.arn]
   health_check_type = "ELB"

   min_size = var.min_size
   max_size = var.max_size

   instance_refresh {
     strategy = "Rolling"
     preferences {
       min_healthy_percentage = 50
     }
   }

   tag {
     key                 = "Name"
     value               = var.cluster_name
     propagate_at_launch = true
   }

}

 resource "aws_lb" "wordpress" {
   name               = var.cluster_name
   load_balancer_type = "application"
   subnets            = data.terraform_remote_state.vpc.outputs.public_subnet
   security_groups    = [aws_security_group.alb.id]
 }

 resource "aws_lb_listener" "http" {
   load_balancer_arn = aws_lb.wordpress.arn
   port              = local.http_port
   protocol          = "HTTP"

   default_action {
     type = "fixed-response"

     fixed_response {
       content_type = "text/plain"
       message_body = "404: page not found"
       status_code  = 404
     }
   }
 }

 resource "aws_lb_target_group" "asg" {
   name     = "${var.cluster_name}-example"
   port     = local.http_port
   protocol = "HTTP"
   vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

   tags = {
     Name = var.cluster_name
   }

   health_check {
     path                = "/"
     protocol            = "HTTP"
     matcher             = "200"
     interval            = 15
     timeout             = 3
     healthy_threshold   = 2
     unhealthy_threshold = 2
   }
 }

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
}

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}


# resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
#   count = var.enable_autoscaling ? 1 : 0
#
#   scheduled_action_name  = "${var.cluster_name}-scale-out-during-business-hours"
#   min_size               = 2
#   max_size               = 10
#   desired_capacity       = 10
#   recurrence             = "0 9 * * *"
#   autoscaling_group_name = aws_autoscaling_group.example.name
# }
#
# resource "aws_autoscaling_schedule" "scale_in_at_night" {
#   count = var.enable_autoscaling ? 1 : 0
#
#   scheduled_action_name  = "${var.cluster_name}-scale-in-at-night"
#   min_size               = 3
#   max_size               = 10
#   desired_capacity       = 3
#   recurrence             = "0 17 * * *"
#   autoscaling_group_name = aws_autoscaling_group.example.name
# }

#resource "aws_instance" "web" {
#  ami           = data.aws_ami.amazon_linux2.id  // Amazon Linux 2 AMI
#  instance_type = "t3.small"
#  key_name      = "wonsoong"
#  subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnet[0]
#  vpc_security_group_ids = [aws_security_group.wordpress.id]
#  private_ip = var.private_ip
#
#  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
#    db_name = var.db_name
#    db_username = var.db_username
#    db_password = var.db_password
#    db_host  = var.db_host
#    db_port     = var.db_port
#  }))
#
#  lifecycle {
#    create_before_destroy = true
#  }
#
#  tags = {
#    Name = "${var.cluster_name}-WEB-"
#  }
#}