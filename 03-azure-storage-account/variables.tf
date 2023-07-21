# Declarando uma variável de entrada
# O rótulo após a variablepalavra-chave é um nome para a variável, que deve ser único entre todas as variáveis ​​do mesmo módulo.
# Este nome é usado para atribuir um valor à variável de fora e para referenciar o valor da variável de dentro do módulo.
variable "location" {

  # #specifica a documentação da variável de entrada.
  description = "Variável que indica a região onde os recursos vão ser criados"

  # Especifica quais tipos de valor são aceitos para a variável.
  type = string

  # Um valor padrão que torna a variável opcional.
  default = "Brazil South"
}

variable "account_tier" {

  description = "Tier da Storage Account na Azure"

  type = string

  default = "Standard"
}

variable "account_replication_type" {

  description = "Tipo de replicação de dados da Storage Account"

  type = string

  default = "LRS"

  # Limita a saída da IU do Terraform quando a variável é usada na configuração.
  sensitive = false
}

