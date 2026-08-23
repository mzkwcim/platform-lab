variable "zone_id" {
  type        = string
  description = "Zone id that we want to use"
}

variable "route_pattern" {
  type        = string
  description = "Pattern accepted by a cloudflare worker route"

  validation {
    condition = startswith(var.route_pattern, "https://")
    error_message = "route_pattern accepts https only"
  }
}

variable "database_id" {
    type = string
    description = "ID of a created database"
}

variable "account_id" {
    type = string
    description = "ID of the binding account"
}

variable "worker_name" {
    type = string
    description = "Name of the worker"
}

variable "d1_binding_name" {
    type = string
    description = "Name of the binding"
}

variable "worker_code_path" {
  type = string
  description = "Path to the worker"
}

