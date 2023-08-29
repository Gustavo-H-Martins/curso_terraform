# Este bloco define a versão mínima do Terraform e os provedores necessários para executar o código
terraform {

  # A versão mínima do Terraform é 1.0.0
  required_version = ">= 1.0.0"

  # O provedor AWS é necessário e deve ser da fonte hashicorp/aws e da versão 3.73.0
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "remote-state"
    storage_account_name = "gustavoremotestate"
    container_name       = "remote-state"
    key                  = "azure-resource-group-null-resource/terraform.tfstate"
  }

}

provider "azurerm" {

  # usando features para autenticar com as variáveis de ambiente
  # o acesso ao ambiente Cloud
  features {}
}