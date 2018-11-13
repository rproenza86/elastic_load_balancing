# Associate the public subnets with the route table
resource "aws_route_table_association" "web_subnets_assotiations" {
  count = 2

  subnet_id      = "${aws_subnet.web_subnet_az.*.id[count.index]}"
  route_table_id = "${aws_route_table.r.id}"
}
