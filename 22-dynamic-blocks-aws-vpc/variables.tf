variable "portas" {
  /*
      Um dynamic block age como uma expressão for , mas produz blocos aninhados em vez de um valor digitado complexo. 
      Ele itera sobre um determinado valor complexo e gera um bloco aninhado para cada elemento desse valor complexo.
    */
  description = "Portas que serão abertas no security group"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}