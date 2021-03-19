##############################################################################
# Gerenciamento de DNS
##############################################################################


// Criacao de Zona DNS e record (A) apontado para o IP do servidor
resource "vultr_dns_domain" "my_domain" {
    domain = var.dns_domain
    ip = vultr_instance.my_instance.main_ip
}

// Criacao de record (CNAME) www
resource "vultr_dns_record" "cname" {
    domain = "${vultr_dns_domain.my_domain.id}"
    name = "www"
    data = "${vultr_dns_domain.my_domain.id}"
    type = "CNAME"
}