terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

resource "cloudflare_d1_database" "swimrankings" {
  account_id = var.account_id
  name       = var.database_name
  read_replication = {
    mode = "disabled"
  }
}