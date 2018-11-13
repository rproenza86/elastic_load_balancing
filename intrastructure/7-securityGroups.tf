# A security group for the web servers so they are  accessible via the web
resource "aws_security_group" "allow_web_traffic" {
  name        = "Web Server Traffic"
  description = "Allow all inbound http traffic"
  vpc_id      = "${aws_vpc.main.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ssh access from anywhere
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

