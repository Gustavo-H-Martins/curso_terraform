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
  # O ID da VPC
  vpc_id = aws_vpc.vpc.id
  # O bloco CIDR IPv4 para a sub-rede
  cidr_block = "10.0.1.0/24"
  # Um mapa de tags para atribuir ao recurso
  tags = {
    Name = "subnet-terraform"
  }
}

# Fornece um recurso para criar um VPC Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  # # O ID da VPC
  vpc_id = aws_vpc.vpc.id
  # Um mapa de tags para atribuir ao recurso
  tags = {
    Name = "internet-gateway-terraform"
  }
}

# Fornece um recurso para criar uma tabela de roteamento VPC
resource "aws_route_table" "route_table" {
  # O ID da VPC
  vpc_id = aws_vpc.vpc.id
  # Uma lista de objetos de rota
  route {
    # O bloco CIDR da rota
    cidr_block = "0.0.0.0/0"
    # Identificador de um gateway de internet VPC, gateway privado virtual, ou `local`
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  # Um mapa de tags para atribuir ao recurso
  tags = {
    Name = "route-table-terraform"
  }
}

/*
    Fornece um recurso para criar uma associação entre uma tabela de roteamento 
    e uma sub-rede ou uma tabela de roteamento e um gateway de internet ou gateway privado virtual
*/
resource "aws_route_table_association" "route_table_association" {
  # O ID da sub-rede para criar uma associação
  subnet_id = aws_subnet.subnet.id
  # O ID da tabela de roteamento para associar
  route_table_id = aws_route_table.route_table.id
}
/*
    Fornece um recurso de grupo de segurança
    O padrão é `Managed by Terraform`. Não pode ser ""
*/
resource "aws_security_group" "security_group" {
  /*
    Nome do grupo de segurança.
    Se omitido, o Terraform atribuirá um nome exclusivo e aleatório 
    */
  name = "security-group-terraform"
  # Descrição do grupo de segurança
  description = "Concede permissão de entrada SSL/TLS a vpc"
  # ID da VPC. O padrão é a VPC padrão da região
  vpc_id = aws_vpc.vpc.id
  /* 
        Bloco de configuração para regras de entrada. 
        Pode ser especificado várias vezes para cada regra de entrada.
    */
  ingress {
    # Descrição desta regra de entrada
    description = "SSL/TLS da VPC"
    # Porta inicial (ou número do tipo ICMP se o protocolo for icmp ou icmpv6)
    from_port = 22
    # Porta do intervalo final (ou código ICMP se o protocolo for icmp)
    to_port = 22
    /*
        Protocolo. 
        Se selecionar um protocolo de -1 
        (semanticamente equivalente a todos, que não é um valor válido aqui), 
        deverá especificar from_port e to_port iguais a 0.
    */
    protocol = "tcp"
    # Lista de blocos CIDR
    cidr_blocks = ["0.0.0.0/0"] # [aws_vpc.vpc.cidr_block]
    # Lista de blocos CIDR IPv6
    ipv6_cidr_blocks = ["::/0"] # [aws_vpc.vpc.ipv6_cidr_block]
  }
  /* 
        Bloco de configuração para regras de saída. 
        Pode ser especificado várias vezes para cada regra de saída.
    */
  egress {
    # Descrição desta regra de saída
    description = "SSL/TLS para VPC"
    # Porta inicial (ou número do tipo ICMP se o protocolo for icmp)
    from_port = 0
    # Porta do intervalo final (ou código ICMP se o protocolo for icmp)
    to_port = 0
    /*
        Protocolo. 
        Se selecionar um protocolo de -1 
        (semanticamente equivalente a todos, que não é um valor válido aqui), 
        deverá especificar from_port e to_port iguais a 0.
    */
    protocol = "-1"
    # Lista de blocos CIDR
    cidr_blocks = ["0.0.0.0/0"]
    # Lista de blocos CIDR IPv6
    ipv6_cidr_blocks = ["::/0"]
  }
}