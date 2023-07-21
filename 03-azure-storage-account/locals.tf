# Valores locais
# Um valor local atribui um nome a uma expressão , portanto, você pode usar o nome várias vezes em um módulo em vez de repetir a expressão.
locals {
  common_tags = {
    owner = "gustavo.lopes"
    managed-by = "terraform"
  }
}