resource "aws_eip" "nat_gateway" {
  vpc   = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.main]
}