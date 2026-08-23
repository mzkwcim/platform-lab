output "dns_record_ids" {
  value       = module.dns_records.dns_record_id
  description = "IDs of Cloudflare DNS records"
}

output "cf_zones_ids" {
  value       = [for f in data.cloudflare_zones.mzkwcim.result : f.id]
  description = "IDs of cloudflare zones"
}