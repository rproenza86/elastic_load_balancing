# Declare the data source
data "aws_availability_zones" "available" {}

# Create a subnet to launch our web server instance into, availability_zone specified to use more than 1 zone
resource "aws_subnet" "web_subnet_az" {
  count = 2

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "Web Server Public Subnet AZ${count.index} - ${data.aws_availability_zones.available.names[count.index]}"
  }
  depends_on = ["aws_internet_gateway.gw"]
}