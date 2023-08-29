# Gerencia um grupo de recursos.
resource "azurerm_resource_group" "resource_group" {

  # O Nome que deve ser usado para este Grupo de Recursos. Alterar isso força a criação de um novo grupo de recursos.
  name = "vnet"

  # A região do Azure onde o grupo de recursos deve existir. Alterar isso força a criação de um novo grupo de recursos.
  location = var.location # "Brazil South"

  # Um mapeamento de tags que devem ser atribuídos ao Grupo de Recursos.
  tags = local.common_tags
}

resource "null_resource" "provisioner" {
  provisioner "local-exec" {
    command = "echo Resource Group ID: ${azurerm_resource_group.resource_group.id} >> resource-group-id.txt"
  }
}