# Public ip assignation to EC2 intances
resource "aws_eip" "web_server_eip" {
  count = 2

  vpc = true
  instance                  = "${aws_instance.web_server.*.id[count.index]}"
  depends_on                = ["aws_internet_gateway.gw"]
}