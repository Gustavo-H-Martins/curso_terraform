# Use esta fonte de dados para obter informações sobre um par de chaves EC2 específico.
resource "aws_key_pair" "key" {
  # Nome do par de chaves.
  key_name = "aws-key"
  # Material de chave pública.
  public_key = file("./aws-key.pub")
}

# Fornece um recurso de instância do EC2.
resource "aws_instance" "vm" {
  # AMI a ser usada para a instância.
  ami = "ami-0aba9f6e2597c6993" # sa-east-1
  # Tipo de instância a ser usado para a instância.
  instance_type = "t4g.nano"
  /*
    Nome da chave do par de chaves a ser usado para a instância; 
    que pode ser gerenciado usando o recurso aws_key_pair.
  */
  key_name = aws_key_pair.key.key_name
  # ID da sub-rede VPC para iniciar.
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
  # Lista de IDs de grupos de segurança a serem associados.
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_id]
  # Se um endereço IP público deve ser associado a uma instância em uma VPC.
  associate_public_ip_address = true

  # O local-execprovisionador chama um executável local depois que um recurso é criado. 
  provisioner "local-exec" {
    #  Este é o comando a ser executado.
    command = "echo ${self.public_ip} >> public_ip.txt"
  }
  # O provisionador de arquivos copia arquivos ou diretórios da máquina que executa o Terraform para o recurso recém-criado.
  provisioner "file" {
    # O conteúdo direto a ser copiado no destino.
    content = "public_ip: ${self.public_ip}"
    # O caminho de destino para gravar no sistema remoto.
    destination = "/tmp/public_ip.txt"
  }
  # O provisionador de arquivos copia arquivos ou diretórios da máquina que executa o Terraform para o recurso recém-criado.
  provisioner "file" {
    # O arquivo ou diretório de origem.
    source = "./arquivo_exemplo.txt"
    # O caminho de destino para gravar no sistema remoto.
    destination = "/temp/exemplo.txt"
  }

  connection {
    # O tipo de conexão. Os valores válidos são "ssh" e "winrm"
    type = "ssh"
    # O usuário a ser usado para a conexão.
    user = "ubuntu"
    # O conteúdo de uma chave SSH a ser usada para a conexão.
    private_key = file("./aws-key")
    # O endereço do recurso ao qual se conectar.
    host = self.public_ip
  }
  # O provisionador remote-exec invoca um script em um recurso remoto após sua criação.
  provisioner "remote-exec" {
    # Esta é uma lista de strings de comando.
    inline = [
      "echo ami: ${self.ami} >> /tmp/ami.txt",
      "echo private_ip: ${self.private_ip} >> /temp/private_ip.txt",
    ]
  }

  # Mapa de tags para atribuir ao recurso.
  tags = {
    "Name" = "vm-terraform-provisioners"
  }
}