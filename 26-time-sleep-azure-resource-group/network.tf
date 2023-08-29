# Gerencia um grupo de recursos.
resource "azurerm_resource_group" "resource_group" {

  # O Nome que deve ser usado para este Grupo de Recursos. Alterar isso força a criação de um novo grupo de recursos.
  name = "time-sleep"

  # A região do Azure onde o grupo de recursos deve existir. Alterar isso força a criação de um novo grupo de recursos.
  location = var.location # "Brazil South"

  # Um mapeamento de tags que devem ser atribuídos ao Grupo de Recursos.
  tags = local.common_tags
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [azurerm_resource_group.resource_group]

  create_duration = "30s"
}
/*
    Gerencia uma rede virtual, incluindo quaisquer sub-redes configuradas. 
    Cada sub-rede pode opcionalmente ser configurada com um security group a ser associado à sub-rede.
*/
resource "azurerm_virtual_network" "vnet" {

  depends_on = [time_sleep.wait_10_seconds]

  # O nome da rede virtual. 
  name = "vnet-terraform-time-sleep"
  # O local/região onde a rede virtual é criada. 
  location = var.location
  # O nome do grupo de recursos no qual criar a rede virtual.
  resource_group_name = azurerm_resource_group.resource_group.name
  # O espaço de endereço que é usado na rede virtual.
  address_space = ["10.0.0.0/16"]
  # Um mapeamento de tags para atribuir ao recurso.
  tags = local.common_tags
}