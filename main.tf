provider "fly" {}

provider "cloudflare" {}

locals {
  domain = "autotelic.dev"
  subdomain = "something"
}

resource "fly_app" "exampleApp" {
  name = "autotelic-fly-tf-test"
  org = "autotelic"
}

resource "fly_cert" "exampleCert" {
  app      = fly_app.exampleApp.name
  hostname = "${subdomain}.${domain}"
}

resource "cloudflare_record" "exampleCertDNSValidation" {
  zone_id = "14bfa107a70e0f04eca5b82d13da7263"
  name    = replace(fly_cert.exampleCert.dnsvalidationhostname, ".${domain}", "")
  value   = fly_cert.exampleCert.dnsvalidationtarget
  type    = "CNAME"
  ttl     = 60
}

resource "cloudflare_record" "exampleAppSubDomain" {
  zone_id = "14bfa107a70e0f04eca5b82d13da7263"
  name    = "${fly_app.exampleApp.name}.fly.dev"
  value   = fly_cert.exampleCert.hostname
  type    = "CNAME"
  ttl     = 60
}
