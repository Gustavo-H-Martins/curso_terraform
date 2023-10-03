# Use esta fonte de dados para obter informações sobre um par de chaves EC2 específico.
resource "aws_key_pair" "key" {
  # Nome do par de chaves.
  key_name = "aws-key"
  # Material de chave pública.
  public_key = file(var.aws_pub_key)
}

# Fornece um recurso de instância do EC2.
resource "aws_instance" "vm" {
  ami           = "ami-0aba9f6e2597c6993" # sa-east-1
  instance_type = "t4g.nano"

  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  tags = {
    "Name" = "vm-terraform"
  }
}