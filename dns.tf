#Importação da zona existente
data "aws_route53_zone" "qangeline" {
  name         = "qangeline.com."
  private_zone = false
}

#Registro DNS apontando para a máquina
resource "aws_route53_record" "www" {
  count = 3
  zone_id = data.aws_route53_zone.qangeline.zone_id
  name    = "vm0${count.index+1}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.ips[count.index].public_ip]
}