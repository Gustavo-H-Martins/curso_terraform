# Gerencia um grupo de recursos.
resource "azurerm_resource_group" "gustavo_first_resource_group_terraform" {

  # O Nome que deve ser usado para este Grupo de Recursos. Alterar isso força a criação de um novo grupo de recursos.
  name = "curso-terraform-gustavo-lopes"

  # A região do Azure onde o grupo de recursos deve existir. Alterar isso força a criação de um novo grupo de recursos.
  location = var.location # "Brazil South"

  # Um mapeamento de tags que devem ser atribuídos ao Grupo de Recursos.
  tags = ""
}

# Gerencia uma conta de armazenamento do Azure.
resource "azurerm_storage_account" "gustavo_first_storage_acount_terraform" {

  # Especifica o nome da conta de armazenamento. Somente caracteres alfanuméricos minúsculos são permitidos. Alterar isso força a criação de um novo recurso. Isso deve ser exclusivo em todo o serviço do Azure, não apenas no grupo de recursos.
  name = ""

  # O nome do grupo de recursos no qual criar a conta de armazenamento. Alterar isso força a criação de um novo recurso.
  resource_group_name = ""

  # Especifica o local do Azure compatível onde o recurso existe. Alterar isso força a criação de um novo recurso.
  location = var.location

  # Define a Camada a ser usada para esta conta de armazenamento. As opções válidas são `Standard` e `Premium`. Para contas `BlockBlobStorage` e `FileStorage`, apenas o `Premium` é válido. Alterar isso força a criação de um novo recurso.
  account_tier = var.account_tier

  # Define o tipo de replicação a ser usado para esta conta de armazenamento. As opções válidas são `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` e `RAGZRS`.
  account_replication_type = var.account_replication_type

  # Um mapeamento de tags para atribuir ao recurso.
  tags = ""
}

# Gerencia um contêiner dentro de uma conta de armazenamento do Azure. 
resource "azurerm_storage_container" "gustavo_first_storage_container_terraform" {

  # O nome do Contêiner que deve ser criado na Conta de Armazenamento. Alterar isso força a criação de um novo recurso.
  name = ""

  # O nome da conta de armazenamento onde o contêiner deve ser criado. Alterar isso força a criação de um novo recurso.
  storage_account_name = ""

  # O nível de acesso configurado para este contêiner. Os valores possíveis são `blob`, `container` ou `private`. O padrão é `private`.
  container_access_type = ""
}