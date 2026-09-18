output "source_ids" {
  description = "Map of storage account key (\"<name>\", optionally suffixed with \"::<container>\" and \"::<path_prefix>\") to the CloudSecure flow logs storage account source ID."
  value       = { for k, source in illumio-cloudsecure_azure_flow_logs_storage_account_source.this : k => source.id }
}

output "storage_account_names" {
  description = "The set of registered storage account names."
  value       = [for a in var.storage_accounts : a.storage_account_name]
}
