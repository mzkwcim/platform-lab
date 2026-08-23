terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

resource "cloudflare_worker" "sr_worker" {
  account_id = var.account_id
  name       = var.worker_name
}

resource "cloudflare_worker_version" "swimrankings_worker" {
  account_id = var.account_id
  worker_id  = cloudflare_worker.sr_worker.id
  bindings = [
    {
      "type" : "d1",
      "name" : var.d1_binding_name,
      "id" : var.database_id
    }
  ]
  modules = [{
    name         = local.worker_file_name
    content_file = var.worker_code_path
    content_type = "application/javascript+module"
  }]
  main_module = local.worker_file_name
}

resource "cloudflare_workers_deployment" "sr_deployment" {
  account_id  = var.account_id
  script_name = cloudflare_worker.sr_worker.name
  strategy    = "percentage"
  versions = [{
    percentage = 100
    version_id = cloudflare_worker_version.swimrankings_worker.id
  }]
}

resource "cloudflare_workers_route" "mzkwcim_test" {
  zone_id = var.zone_id
  pattern = var.route_pattern
  script  = cloudflare_worker.sr_worker.name
}