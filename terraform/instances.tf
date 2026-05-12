resource "aws_instance" "public_node" {
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.small" # Recomendado t3.small por RAM
  subnet_id     = aws_subnet.public.id
  user_data     = file("scripts/setup_public.sh")
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  key_name      = "vockey"
}

resource "aws_instance" "private_node" {
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.private.id
  private_ip    = "10.0.2.100" # IP fija para el proxy
  user_data     = file("scripts/setup_private.sh")
  vpc_security_group_ids = [aws_security_group.allow_internal.id]
  key_name      = "vockey"
}
