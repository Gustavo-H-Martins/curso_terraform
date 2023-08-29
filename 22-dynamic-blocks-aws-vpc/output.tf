# Define três blocos de saída (output) que exibem os IDs de recursos criados pelo Terraform.

# O primeiro bloco de saída exibe o ID da sub-rede criada pelo recurso "aws_subnet".
output "subnet_id" {
  value = aws_subnet.subnet.id
}

# O segundo bloco de saída exibe o ID do grupo de segurança criado pelo recurso "aws_security_group".
output "security_group_id" {
  value = aws_security_group.security_group.id
}

# O terceiro bloco de saída exibe o ID da tabela de roteamento criada pelo recurso "aws_route_table".
output "route_table_id" {
  value = aws_route_table.route_table.id
}
