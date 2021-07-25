#Grupo de segurança
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.aline_vpc.id

  ingress {
    description      = "SSH from Home"
    from_port        = 0
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.my_ip}/32"]
  }

  ingress {
    description      = "HTTP from Anywhere"
    from_port        = 0
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}