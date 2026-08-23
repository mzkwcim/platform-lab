variable "account_id" {
  type        = string
  description = "My account id"
}

variable "domain_name" {
  type        = string
  description = "My domain"
}

variable "dns_records" {
  type = map(object({
    name    = string
    ttl     = optional(number, 1)
    type    = string
    content = string
    proxied = bool
  }))
  description = "DNS record structure"
}

variable "d1_binding_name" {
  type        = string
  description = "Name of the D1 binding passed to the worker module"
}

variable "worker_name" {
  type        = string
  description = "Name of the Cloudflare Worker"
}

variable "worker_code_path" {
  type        = string
  description = "Path to the worker"
}

variable "database_name" {
  type        = string
  description = "Name of the database"
}
