# Gerencia um endereço IP público.
resource "azurerm_resource_group" "resource_group" {
  # O Nome que deve ser usado para este Grupo de Recursos.
  name = "vm"
  # A região do Azure onde o grupo de recursos deve existir.
  location = var.location
  # Um mapeamento de tags que devem ser atribuídos ao Grupo de Recursos.
  tags = local.common_tags
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
    subnet_id = data.terraform_remote_state.vnet.outputs.subnet_id
    # O método de alocação usado para o endereço IP privado.
    private_ip_address_allocation = "Dynamic"
    # Referência a um endereço IP público para associar a este NIC
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
  # Um mapeamento de tags para atribuir ao recurso.
  tags = local.common_tags
}

# Gerencia a associação entre uma interface de rede e um grupo de segurança de rede.
resource "azurerm_network_interface_security_group_association" "nic_group_association" {
  # O ID da interface de rede. Alterar isso força a criação de um novo recurso.
  network_interface_id = azurerm_network_interface.network_interface.id
  # O ID do grupo de segurança de rede que deve ser anexado à interface de rede.
  network_security_group_id = data.terraform_remote_state.vnet.outputs.security_group_id
}

# Gerencia uma máquina virtual Linux.
resource "azurerm_linux_virtual_machine" "vm" {
  # O nome da máquina virtual do Linux.
  name = "vm-terraform"
  # O nome do Grupo de Recursos no qual a Máquina Virtual Linux deve existir.
  resource_group_name = azurerm_resource_group.resource_group.name
  # O local do Azure onde a máquina virtual do Linux deve existir.
  location = var.location
  # O SKU que deve ser usado para esta máquina virtual, como `Standard_F2`
  size = "Standard_B1s"
  # O nome de usuário do administrador local usado para a máquina virtual.
  admin_username = "terraform"
  # Uma lista de IDs de interface de rede que devem ser anexados a esta máquina virtual.
  network_interface_ids = [azurerm_network_interface.network_interface.id]

  # O local-execprovisionador chama um executável local depois que um recurso é criado. 
  provisioner "local-exec" {
    #  Este é o comando a ser executado.
    command = "echo ${self.public_ip_address} >> public_ip.txt"
  }
  # O provisionador de arquivos copia arquivos ou diretórios da máquina que executa o Terraform para o recurso recém-criado.
  provisioner "file" {
    # O conteúdo direto a ser copiado no destino.
    content = "public_ip: ${self.public_ip_address}"
    # O caminho de destino para gravar no sistema remoto.
    destination = "/tmp/public_ip.txt"
  }
  # O provisionador de arquivos copia arquivos ou diretórios da máquina que executa o Terraform para o recurso recém-criado.
  provisioner "file" {
    # O arquivo ou diretório de origem.
    source = "./teste"
    # O caminho de destino para gravar no sistema remoto.
    destination = "/tmp"
  }

  connection {
    # O tipo de conexão. Os valores válidos são "ssh" e "winrm"
    type = "ssh"
    # O usuário a ser usado para a conexão.
    user = "terraform"
    # O conteúdo de uma chave SSH a ser usada para a conexão.
    private_key = file("./azure -key")
    # O endereço do recurso ao qual se conectar.
    host = self.public_ip_address
  }
  # O provisionador remote-exec invoca um script em um recurso remoto após sua criação.
  provisioner "remote-exec" {
    # Esta é uma lista de strings de comando.
    inline = [
      "echo location: ${var.location} >> /tmp/location.txt",
      "echo subnet_id: ${data.terraform_remote_state.vnet.outputs.subnet_id} >> /temp/subnet_id.txt",
    ]
  }

  # Um ou mais blocos admin_ssh_key conforme definido abaixo.
  admin_ssh_key {
    # O nome de usuário para o qual esta chave SSH pública deve ser configurada.
    username = "terraform"
    # A chave pública que deve ser usada para autenticação, que precisa ser de pelo menos 2048 bits e no formato ssh-rsa.
    public_key = file("./azure-key.pub")
  }
  # Um bloco os_disk conforme definido abaixo
  os_disk {
    # O tipo de cache que deve ser usado para o disco interno do sistema operacional.
    caching = "ReadWrite"
    # O tipo de conta de armazenamento que deve suportar o disco interno do sistema operacional.
    storage_account_type = "Standard_LRS"
  }
  # Um bloco source_image_reference conforme definido abaixo.
  source_image_reference {
    # Especifica o editor da imagem usada para criar as máquinas virtuais.
    publisher = "Canonical"
    # Especifica a oferta da imagem usada para criar as máquinas virtuais.
    offer = "0001-com-ubuntu-server-focal"
    # Especifica o SKU da imagem usada para criar as máquinas virtuais.
    sku = "20_04-lts"
    # Especifica a versão da imagem usada para criar as máquinas virtuais.
    version = "latest"
  }

  # Um mapeamento de tags para atribuir ao recurso.
  tags = local.common_tags
}