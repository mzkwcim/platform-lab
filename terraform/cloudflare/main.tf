terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {

}

resource "cloudflare_dns_record" "lab_record" {
  zone_id = "722e52e42c601df6ef196cd381347779"
  name    = "terraform-lab.mzkwcim.net"
  ttl     = 1
  type    = "CNAME"
  content = "mzkwcim.net"
  proxied = false
}