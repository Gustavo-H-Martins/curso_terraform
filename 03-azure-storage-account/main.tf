# Bloco Terraform
terraform {

  # Colocando a versão requerida do Terraform
  required_version = ">=1.0.0"

  # Definindo o provider no caso Azure Microsoft
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.66.0"
    }
  }
}

provider "azurerm" {
  # usando features para autenticar com as variáveis de ambiente
  # o acesso ao ambiente Cloud
  features {}
}