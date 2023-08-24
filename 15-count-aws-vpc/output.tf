# Define três blocos de saída (output) que exibem os IDs de recursos criados pelo Terraform.

# O primeiro bloco de saída exibe o ID da sub-rede criada pelo recurso "aws_subnet".
output "subnet_0_id" {
  value = aws_subnet.subnet[0].id
}

# O primeiro bloco de saída exibe o ID da sub-rede criada pelo recurso "aws_subnet".
output "subnet_1_id" {
  value = aws_subnet.subnet[1].id
}

# O primeiro bloco de saída exibe o ID da sub-rede criada pelo recurso "aws_subnet".
output "subnet_2_id" {
  value = aws_subnet.subnet[2].id
}