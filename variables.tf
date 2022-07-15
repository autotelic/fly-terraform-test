variable "zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "fly_app_name" {
  description = "Fly.io app name"
  type        = string
}

variable "fly_org_name" {
  description = "Fly.io org name"
  type        = string
}

variable "domain" {
  description = "Domain for API"
  type        = string
}

variable "subdomain" {
  description = "Sub Domain for API"
  type        = string
  default     = ""
}
