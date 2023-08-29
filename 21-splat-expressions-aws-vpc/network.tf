# Fornece um recurso de VPC
resource "aws_vpc" "vpc" {
  # O bloco CIDR IPv4 para a VPC. O CIDR pode ser definido explicitamente ou pode ser derivado do IPAM usando `ipv4_netmask_length`
  cidr_block = "10.0.0.0/16"
  # Um mapa de tags para atribuir ao recurso
  tags = {
    Name = "vpc-terraform"
  }
}

# Fornece um recurso de sub-rede VPC
resource "aws_subnet" "subnet" {
  /*
    Uma forexpressão cria um valor de tipo complexo transformando outro valor de tipo complexo. 
    Cada elemento no valor de entrada pode corresponder a um ou zero valores no resultado, 
    e uma expressão arbitrária pode ser usada para transformar cada elemento de entrada em um elemento de saída.
  */
  count = 3
  # O ID da VPC
  vpc_id = aws_vpc.vpc.id
  # O bloco CIDR IPv4 para a sub-rede
  cidr_block = "10.0.${count.index}.0/24"
  # Um mapa de tags para atribuir ao recurso
  tags = {
    Name = "subnet-terraform-${count.index}"
  }
}