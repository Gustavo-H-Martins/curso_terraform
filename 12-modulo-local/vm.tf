# Use esta fonte de dados para obter informações sobre um par de chaves EC2 específico.
resource "aws_key_pair" "key" {
  # Nome do par de chaves.
  key_name = "aws-key"
  # Material de chave pública.
  public_key = file("./aws-key.pub")
}

# Fornece um recurso de instância do EC2.
resource "aws_instance" "vm" {
  /*
    AMI a ser usada para a instância. 
    Obrigatório, a menos que launch_template seja especificado e o Launch Template especifique uma AMI.
  */
  ami = "ami-0aba9f6e2597c6993" # sa-east-1
  # Tipo de instância a ser usado para a instância.
  instance_type = "t4g.nano"

  /*
    Nome da chave do par de chaves a ser usado para a instância; 
    que pode ser gerenciado usando o recurso aws_key_pair.
  */
  key_name = aws_key_pair.key.key_name
  # ID da sub-rede VPC para iniciar.
  subnet_id = module.network.subnet_id
  # Lista de IDs de grupos de segurança a serem associados.
  vpc_security_group_ids = [module.networt.security_group_id]
  # Se um endereço IP público deve ser associado a uma instância em uma VPC.
  associate_public_ip_address = true

  # Mapa de tags para atribuir ao recurso.
  tags = {
    "Name" = "vm-terraform"
  }
}