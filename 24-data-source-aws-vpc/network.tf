/*
  As fontes de dados permitem que o Terraform use informações definidas fora do Terraform, 
  definidas por outra configuração separada do Terraform ou modificadas por funções.
*/
data "aws_vpc" "vpc_data" {
  cidr_block = "10.0.1.0/16"
}

# Fornece um recurso de sub-rede VPC
resource "aws_subnet" "subnet" {
  # O ID da VPC
  vpc_id = data.aws_vpc.vpc_data.id
  # O bloco CIDR IPv4 para a sub-rede
  cidr_block = "10.0.10.0/24"
  # Um mapa de tags para atribuir ao recurso
  tags = {
    Name = "subnet-terraform"
  }
}