output "dns_record_id" {
  value       = { for k, v in cloudflare_dns_record.lab_record : k => v.id }
  description = "IDs of the Cloudflare DNS records"
}