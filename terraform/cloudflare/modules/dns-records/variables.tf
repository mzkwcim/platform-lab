variable "zone_id" {
  type        = string
  description = "Zone id that we want to use"
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

  validation {
    condition     = alltrue([for v in var.dns_records : contains(local.allowed_dns_types, v.type)])
    error_message = "One or more of the dns types isn't on allowed list, please check it"
  }

  validation {
    condition = alltrue([
      for v in var.dns_records :
      v.ttl - floor(v.ttl) == 0 &&
      (v.ttl == 1 || (v.ttl >= 60 && v.ttl <= 86400))
    ])
    error_message = "TTL needs to be an integera, set to 1 or in range between 60 and 86400"
  }

  validation {
    condition     = alltrue([for v in var.dns_records : trimspace(v.name) != ""])
    error_message = "Name can not be empty or consits of only whitespaces"
  }

  validation {
    condition     = alltrue([for v in var.dns_records : !v.proxied || contains(["A", "AAAA", "CNAME"], v.type)])
    error_message = "When proxied is true, record type must be A, AAAA, or CNAME."
  }
}