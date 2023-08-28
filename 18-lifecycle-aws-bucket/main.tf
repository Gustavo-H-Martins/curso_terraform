# Este bloco define a versão mínima do Terraform e os provedores necessários para executar o código
terraform {

  # A versão mínima do Terraform é 1.0.0
  required_version = ">= 1.0.0"

  # O provedor AWS é necessário e deve ser da fonte hashicorp/aws e da versão 3.73.0
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
  }
  # Armazena o estado como uma determinada chave em um determinado bucket no Amazon S3 .
  # https://developer.hashicorp.com/terraform/language/settings/backends/s3
  backend "s3" {
    # Isso pressupõe que temos um bucket criado chamado:
    bucket = "gustavolopes-remote-state"
    # O estado do Terraform é gravado na chave:
    key = "aws-bucket-lifecycle/terraform.tfstate"
    # Região para alocar o state
    region = "sa-east-1"
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