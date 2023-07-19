# Configurações globais do Terraform
terraform {
  # Versão mínima do Terraform requerida para este arquivo
  required_version = "~> 1.0.0" # 1.0.0 até 1.0.n

  # Provedores de recursos requeridos e suas versões
  required_providers {
    aws = {
        version = "1.0"
        source = "hashicorp/aws"
    }

    azurerm = {
        version = "2.0"
        source = "hashicorp/azurerm"
    }
  }

  # Configuração do backend para armazenamento do estado remoto
  backend "azurerm" {

  }
}
