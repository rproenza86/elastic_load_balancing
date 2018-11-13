# Create a new load balancer and mandatories components
resource "aws_lb" "web_servers_lb" {
  name               = "web-servers-lb"
  internal           = false
  load_balancer_type = "application"

  subnets         = ["${aws_subnet.web_subnet_az.*.id}"]
  security_groups = ["${aws_security_group.allow_web_traffic.id}"]

  tags {
    Name = "web-servers-elb"
  }
}

resource "aws_lb_target_group" "webserver_target_group" {
  name     = "WebserverTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.web_servers_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.webserver_target_group.arn}"
  }
}

resource "aws_lb_target_group_attachment" "alb_instance_attachement" {
  count            = 2

  target_group_arn = "${aws_lb_target_group.webserver_target_group.arn}"
  target_id        = "${aws_instance.web_server.*.id[count.index]}"
  port             = 80
}
