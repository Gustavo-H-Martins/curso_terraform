# Output Values
# Cada valor de saída exportado por um módulo deve ser declarado usando um `output` bloco:
output "storage_account_id" {

  # A ID da conta de armazenamento.
  value = azurerm_storage_account.gustavo_first_storage_acount_terraform.id
}