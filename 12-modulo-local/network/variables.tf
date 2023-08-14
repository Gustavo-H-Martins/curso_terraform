# Declarando uma variável de entrada
# O rótulo após a variablepalavra-chave é um nome para a variável, que deve ser único entre todas as variáveis ​​do mesmo módulo.
# Este nome é usado para atribuir um valor à variável de fora e para referenciar o valor da variável de dentro do módulo.
variable "cidr_vpc" {

  #specifica a documentação da variável de entrada.
  description = "Variável que indica o cidr_block da vpc"

  # Especifica quais tipos de valor são aceitos para a variável.
  type = string

  # Um valor padrão que torna a variável opcional.
  #default = "10.0.1.0/24"
}

# Este nome é usado para atribuir um valor à variável de fora e para referenciar o valor da variável de dentro do módulo.
variable "cidr_subnet" {

  # Especifica a documentação da variável de entrada.
  description = "Variável que indica o cidr_block da vpc da subnet"

  # Especifica quais tipos de valor são aceitos para a variável.
  type = string

}
# Este nome é usado para atribuir um valor à variável de fora e para referenciar o valor da variável de dentro do módulo.
variable "enviroment" {

  # Especifica a documentação da variável de entrada.
  description = "Variável que indica o ambiente onde o recurso será utilizado"

  # Especifica quais tipos de valor são aceitos para a variável.
  type = string

  # Um valor padrão que torna a variável opcional.
  default = "terraform"
}