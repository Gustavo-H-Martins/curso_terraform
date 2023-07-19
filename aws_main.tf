# Configurações globais do Terraform
terraform {
  
}

# Provedor de recursos AWS
provider "aws" {
  
}

# Recurso de instância EC2 da AWS
resource "aws_instance" "vm1" {
  
}

# Fonte de dados para buscar informações sobre AMIs da AWS
data "aws_ami" "image" {
  
}

# Módulo de rede personalizado
module "network" {
  
}

# Variável para armazenar o nome da instância EC2
variable "vm_name" {
  
}

# Saída que exibe o endereço IP da instância EC2
output "vm1_ip" {
  
}

# Variáveis locais para uso interno no arquivo
locals {
  
}
