# Create a Virtual Private Cloud to launch our instances into
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "Web Server VPC"
  }
}