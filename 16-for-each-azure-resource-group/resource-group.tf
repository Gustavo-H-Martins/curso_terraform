# Gerencia um grupo de recursos.
resource "azurerm_resource_group" "resource_group" {
  /*
    `for_each´ é um meta-argumento definido pela linguagem Terraform. 
    Pode ser usado com módulos e com todos os tipos de recursos.
  */
  for_each = {
    "EUA"    = "East US"
    "Europa" = "West Europe"
    "Asia"   = "Japan East"
  }
  # O Nome que deve ser usado para este Grupo de Recursos. Alterar isso força a criação de um novo grupo de recursos.
  name = each.key

  # A região do Azure onde o grupo de recursos deve existir. Alterar isso força a criação de um novo grupo de recursos.
  location = each.value

  # Um mapeamento de tags que devem ser atribuídos ao Grupo de Recursos.
  tags = local.common_tags
}
