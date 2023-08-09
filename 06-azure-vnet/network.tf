# Gerencia um grupo de recursos.
resource "azurerm_resource_group" "resource_group" {

  # O Nome que deve ser usado para este Grupo de Recursos. Alterar isso força a criação de um novo grupo de recursos.
  name = "vnet"

  # A região do Azure onde o grupo de recursos deve existir. Alterar isso força a criação de um novo grupo de recursos.
  location = var.location # "Brazil South"

  # Um mapeamento de tags que devem ser atribuídos ao Grupo de Recursos.
  tags = local.common_tags
}
/*
    Gerencia uma rede virtual, incluindo quaisquer sub-redes configuradas. 
    Cada sub-rede pode opcionalmente ser configurada com um security group a ser associado à sub-rede.
*/
resource "azurerm_virtual_network" "vnet" {
  # O nome da rede virtual. 
  name = "vnet-terraform"
  # O local/região onde a rede virtual é criada. 
  location = var.location
  # O nome do grupo de recursos no qual criar a rede virtual.
  resource_group_name = azurerm_resource_group.resource_group.name
  # O espaço de endereço que é usado na rede virtual.
  address_space = ["10.0.0.0/16"]
  # Um mapeamento de tags para atribuir ao recurso.
  tags = local.common_tags
}
/*
    Gerencia uma sub-rede. 
    As sub-redes representam segmentos de rede dentro do espaço IP definido pela rede virtual.
*/
resource "azurerm_subnet" "subnet" {
  # O nome da sub-rede.
  name = "subnet-terraform"
  # O nome do grupo de recursos no qual criar a sub-rede.
  resource_group_name = azurerm_resource_group.resource_group.name
  # O nome da rede virtual à qual anexar a sub-rede.
  virtual_network_name = azurerm_virtual_network.vnet.name
  # Os prefixos de endereço a serem usados ​​para a sub-rede.
  address_prefixes = ["10.0.1.0/24"]
}
/*
    Gerencia um grupo de segurança de rede que contém uma lista de regras de segurança de rede. 
    Os grupos de segurança de rede permitem que o tráfego de entrada ou saída seja habilitado ou negado.
*/
resource "azurerm_network_security_group" "network_security_group" {
  # Especifica o nome do grupo de segurança de rede.
  name = "network_security_group-terraform"
  # Especifica o local do Azure compatível onde o recurso existe.
  location = var.location
  # O nome do grupo de recursos no qual criar o grupo de segurança de rede.
  resource_group_name = azurerm_resource_group.resource_group.name
  # Lista de objetos que representam regras de segurança
  security_rule {
    # O nome da regra de segurança.
    name = "ssh"
    /*
        Especifica a prioridade da regra. 
        O valor pode estar entre 100 e 4096. 
        O número de prioridade deve ser exclusivo para cada regra na coleção. 
        Quanto menor o número de prioridade, maior a prioridade da regra.
    */
    priority = 100
    /*
        A direção especifica se a regra será avaliada no tráfego de entrada ou saída. 
        Os valores possíveis são 'Inbound' Entrada e 'Outbound' Saída.
    */
    direction = "Inbound"
    # Especifica se o tráfego de rede é permitido ou negado.
    access = "Allow"
    # Protocolo de rede ao qual esta regra se aplica.
    protocol = "Tcp"
    /*
        Porta ou intervalo de origem. 
        Número inteiro ou intervalo entre 0 e 65535 ou * para corresponder a qualquer um.
    */
    source_port_range = "*"
    /*
        Porta ou intervalo de destino. 
        Número inteiro ou intervalo entre 0 e 65535 ou * para corresponder a qualquer um.
    */
    destination_port_range = "22"
    # CIDR ou intervalo de IP de origem ou * para corresponder a qualquer IP.
    source_address_prefix = "*"
    # CIDR ou intervalo de IP de destino ou * para corresponder a qualquer IP.
    destination_address_prefix = "*"
  }
  # Um mapeamento de tags para atribuir ao recurso.
  tags = local.common_tags
}
# Associa um grupo de segurança de rede a uma sub-rede em uma rede virtual.
resource "azurerm_subnet_network_security_group_association" "example" {
  # O ID da sub-rede. Alterar isso força a criação de um novo recurso.
  subnet_id = azurerm_subnet.subnet.id
  # O ID do Grupo de Segurança de Rede que deve ser associado à Sub-rede.
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}