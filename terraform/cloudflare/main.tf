terraform {
  required_version = "~> 1.15"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.23"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.6"
    }
  }
}

provider "cloudflare" {

}

module "dns_records" {
  source = "./modules/dns-records"

  zone_id     = data.cloudflare_zones.mzkwcim.result[0].id
  domain_name = var.domain_name
  dns_records = var.dns_records
}

data "cloudflare_zones" "mzkwcim" {
  account = {
    id = var.account_id
  }
  name = var.domain_name

  lifecycle {
    postcondition {
      condition     = length(self.result) == 1
      error_message = "There is no exactly one zone id connected to the cloudflare zone"
    }
  }
}

moved {
  from = cloudflare_dns_record.lab_record
  to   = module.dns_records.cloudflare_dns_record.lab_record
}

module "worker" {
  source = "./modules/worker"

  zone_id          = data.cloudflare_zones.mzkwcim.result[0].id
  route_pattern    = local.route_pattern
  database_id      = module.database.database_id
  account_id       = var.account_id
  d1_binding_name  = var.d1_binding_name
  worker_name      = var.worker_name
  worker_code_path = var.worker_code_path
}

module "database" {
  source = "./modules/database"

  account_id    = var.account_id
  database_name = var.database_name
}

check "worker_health" {
  data "http" "mzkwcim" {
    url = "https://mzkwcim.net/health"

    request_headers = {
      Accept = "application/json"
    }

    method = "GET"
  }

  assert {
    condition     = data.http.mzkwcim.status_code == 200
    error_message = "Worker health endpoint did not return HTTP 201."
  }
}

moved {
  from = cloudflare_worker.sr_worker
  to   = module.worker.cloudflare_worker.sr_worker
}

moved {
  from = cloudflare_worker_version.swimrankings_worker
  to   = module.worker.cloudflare_worker_version.swimrankings_worker
}

moved {
  from = cloudflare_workers_deployment.sr_deployment
  to   = module.worker.cloudflare_workers_deployment.sr_deployment
}

moved {
  from = cloudflare_workers_route.mzkwcim_test
  to   = module.worker.cloudflare_workers_route.mzkwcim_test
}

moved {
  from = cloudflare_d1_database.swimrankings
  to   = module.database.cloudflare_d1_database.swimrankings
}