# EC2 instances creation
resource "aws_instance" "web_server" {
  count = 2

  ami = "ami-0ff8a91507f77f867"
  instance_type = "t2.micro"
  monitoring    = true
  subnet_id = "${aws_subnet.web_subnet_az.*.id[count.index]}"

  # Our Security group to allow inbound HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.allow_web_traffic.id}"]

  tags {
    Name        = "Web Server ${count.index}"
    Terraform   = "true"
    Environment = "dev"
  }

  user_data = <<HEREDOC
#!/bin/sh
yum -y install httpd php
chkconfig httpd on
/etc/init.d/httpd start
cd /var/www/html
wget https://s3-us-west-2.amazonaws.com/us-west-2-aws-training/awsu-spl/spl-03/scripts/examplefiles-elb.zip
unzip examplefiles-elb.zip
HEREDOC
}


