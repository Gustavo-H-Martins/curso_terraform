# Este bloco define a versão mínima do Terraform e os provedores necessários para executar o código
terraform {

  # A versão mínima do Terraform é 1.0.0
  required_version = ">= 1.0.0"

  # O provedor AWS é necessário e deve ser da fonte hashicorp/aws e da versão 3.73.0
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
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