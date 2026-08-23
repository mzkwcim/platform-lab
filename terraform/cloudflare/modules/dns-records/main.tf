terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

resource "cloudflare_dns_record" "lab_record" {
  for_each = var.dns_records
  zone_id  = var.zone_id
  name     = "${each.value.name}.${var.domain_name}"
  ttl      = each.value.ttl
  type     = each.value.type
  content  = each.value.content
  proxied  = each.value.proxied
}