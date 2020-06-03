## Creating Launch Configuration
resource "aws_launch_configuration" "stage" {
  image_id               = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.instance.id}"]
  key_name               = var.KEY_NAME
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, HSBC team!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}
## Creating AutoScaling Group
resource "aws_autoscaling_group" "stage-autoscaling" {
  launch_configuration = aws_launch_configuration.stage.id
  availability_zones = data.aws_availability_zones.all.names
  min_size = 2
  max_size = 5
  load_balancers = [aws_elb.stage-elb.name]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "terraform-asg-stage"
    propagate_at_launch = true
  }
}