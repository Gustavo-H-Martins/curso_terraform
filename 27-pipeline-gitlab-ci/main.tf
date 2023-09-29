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
    key                  = "azure-vm/terraform.tfstate"
  }

}

provider "azurerm" {

  # usando features para autenticar com as variáveis de ambiente
  # o acesso ao ambiente Cloud
  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "remote-state"
    storage_account_name = "gustavoremotestate"
    container_name       = "remote-state"
    key                  = "pipeline-gitlab-ci/terraform.tfstate"
  }
}

# Este bloco configura o provedor AWS com a região sa-east-1 e as tags padrão para todos os recursos criados
provider "aws" {

  # A região onde os recursos serão criados é sa-east-1
  region = "sa-east-1"

  # As tags padrão para todos os recursos são owner e managed-by
  default_tags {
    tags = {
      owner      = "gustavo.lopes"
      managed-by = "terraform"
    }
  }
}
/*
  A fonte de dados terraform_remote_state retornará todas as saídas do módulo raiz 
  definidas no estado remoto referenciado (mas não nenhuma saída de módulos aninhados, 
  a menos que sejam explicitamente geradas novamente na raiz)
*/
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    # Isso pressupõe que temos um bucket criado chamado:
    bucket = "gustavolopes-remote-state"
    # O estado do Terraform é gravado na chave:
    key = "aws-vpc/terraform.tfstate"
    # Região para alocar o state
    region = "sa-east-1"
  }
}
