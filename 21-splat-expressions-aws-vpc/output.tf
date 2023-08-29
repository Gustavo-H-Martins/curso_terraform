# Define três blocos de saída (output) que exibem os IDs de recursos criados pelo Terraform.

# O primeiro bloco de saída exibe o ID da sub-rede criada pelo recurso "aws_subnet".
output "subnet_id" {
  value = aws_subnet.subnet[*].id
}
