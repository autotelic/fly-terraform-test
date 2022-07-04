provider "fly" {}

provider "cloudflare" {}

locals {
  domain = "autotelic.dev"
  subdomain = "something"
  zone_id = "14bfa107a70e0f04eca5b82d13da7263"
}

resource "fly_app" "exampleApp" {
  name = "autotelic-fly-tf-test"
  org = "autotelic"
}

resource "fly_cert" "exampleCert" {
  app      = fly_app.exampleApp.name
  hostname = "${local.subdomain}.${local.domain}"
}

resource "cloudflare_record" "exampleCertDNSValidation" {
  zone_id = local.zone_id
  name    = replace(fly_cert.exampleCert.dnsvalidationhostname, ".${local.domain}", "")
  value   = fly_cert.exampleCert.dnsvalidationtarget
  type    = "CNAME"
  ttl     = 60
}

resource "cloudflare_record" "exampleAppSubDomain" {
  zone_id = local.zone_id
  name    = local.subdomain
  value   = "${fly_app.exampleApp.name}.fly.dev"
  type    = "CNAME"
  proxied = true
}
