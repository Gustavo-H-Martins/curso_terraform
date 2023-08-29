# Fornece um recurso de VPC
resource "aws_vpc" "vpc" {
  /*
  `count´ é um meta-argumento definido pela linguagem Terraform. 
  Pode ser usado com módulos e com todos os tipos de recursos.
  */
  count = var.enviroment == "prod" ? 1 : 0

  # O bloco CIDR IPv4 para a VPC. O CIDR pode ser definido explicitamente ou pode ser derivado do IPAM usando `ipv4_netmask_length`
  cidr_block = "10.0.0.0/16"
  # Um mapa de tags para atribuir ao recurso
  tags = {
    Name = "vpc-terraform"
  }
}