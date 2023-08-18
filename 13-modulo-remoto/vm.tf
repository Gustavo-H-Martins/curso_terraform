# Gerencia um endereço IP público.
resource "azurerm_resource_group" "resource_group" {
  name     = "modulo-remoto"
  location = var.location
  tags     = local.common_tags
}


# Gerencia um endereço IP público.
resource "azurerm_public_ip" "public_ip" {
  # Especifica o nome do IP público.
  name = "public-ip-terraform"
  # O nome do Grupo de Recursos onde este IP Público deve existir.
  resource_group_name = azurerm_resource_group.resource_group.name
  # Especifica o local do Azure com suporte onde o IP público deve existir.
  location = var.location
  # Define o método de alocação para este endereço IP.
  allocation_method = "Dynamic"
  # Um mapeamento de tags para atribuir ao recurso.
  tags = local.common_tags
}

# Gerencia uma interface de rede.
resource "azurerm_network_interface" "network_interface" {
  name = "network-interface-terraform"
  # O local onde a interface de rede deve existir.
  location = var.location
  # O nome do Grupo de Recursos no qual criar a Interface de Rede.
  resource_group_name = azurerm_resource_group.resource_group.name
  # Um ou mais blocos ip_configuration
  ip_configuration {
    # Um nome usado para esta configuração de IP.
    name = "public-ip-terraform"
    # O ID da sub-rede onde esta interface de rede deve estar localizada.
    subnet_id = module.network.vnet_subnets[0]
    # O método de alocação usado para o endereço IP privado.
    private_ip_address_allocation = "Dynamic"
    # Referência a um endereço IP público para associar a este NIC
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  tags = local.common_tags
}

# Gerencia a associação entre uma interface de rede e um grupo de segurança de rede.
resource "azurerm_network_interface_security_group_association" "nic_group_association" {
  # O ID da interface de rede. Alterar isso força a criação de um novo recurso.
  network_interface_id = azurerm_network_interface.network_interface.id
  # O ID do grupo de segurança de rede que deve ser anexado à interface de rede.
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

# Gerencia uma máquina virtual Linux.
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-terraform"
  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username        = "terraform"
  network_interface_ids = [azurerm_network_interface.network_interface.id]

  admin_ssh_key {
    username   = "terraform"
    public_key = file("./azure-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  tags = local.common_tags
}