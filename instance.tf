#Chave rsa
resource "aws_key_pair" "aline_key" {
  key_name   = "aline-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNEy6sT8oY2Ey/aKT8Uwvf2n7l9923kjikvdLuCK1dfTzshsgy7AeY8/3vwoWz8xWURNKbxcIuwTjKZuSS7v99MTMH805Mae7HTex3+kaMZEju4rMmTu0euVQkJgAcRIHC13lvifH1ypzQBf9hE5SctC6hcS718bwJA+oQi5Vvz6rMI30DX0Hn5Sy5sfypx5I9suVq6UnFovWJCeBSfnRv4qoImYG3repAV8aOmNdtPg4A7hugL7jJ0N7gVy3m4rlWF4O3+2wSJ9RPAOsdlyNdnXTLpbw2/GL0SGFAC+hc4reaiEmAX97BDHNhrQ5leJWP3vgQ9Z5weiTa6oDztzNH alineds@lnxcit018744"
}

#Placa de rede que será usada pela instância
resource "aws_network_interface" "interface" {
  subnet_id   = aws_subnet.vms.id
  private_ips = ["10.0.0.100"]
  security_groups = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "primary_network_interface"
  }
}

#IP públic
resource "aws_eip" "ip_01" {
  vpc                       = true
  network_interface         = aws_network_interface.interface.id
  associate_with_private_ip = "10.0.0.100"
}

#Instância aline-vm-01
resource "aws_instance" "aline_vm_01" {

  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t3.micro"
  availability_zone = "us-east-1a"
  key_name          = aws_key_pair.aline_key.key_name
  
  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }

  tags = {
    Name = "aline-vm-01"
  }
}

