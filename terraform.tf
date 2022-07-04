terraform {
  required_providers {
    fly = {
      source = "fly-apps/fly"
      version = "0.0.9"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.18.0"
    }
  }
}
