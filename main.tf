provider "fly" {}

provider "cloudflare" {}

resource "fly_app" "exampleApp" {
  name = var.fly_app_name
  org = var.fly_org_name
}

resource "fly_cert" "exampleAppCert" {
  app      = fly_app.apiApp.name
  hostname = "${var.subdomain}.${var.domain}"
}

resource "cloudflare_record" "exampleAppCertDNSValidation" {
  zone_id = var.zone_id
  name    = replace(fly_cert.apiAppCert.dnsvalidationhostname, ".${var.domain}", "")
  value   = fly_cert.apiAppCert.dnsvalidationtarget
  type    = "CNAME"
  ttl     = 60
}

resource "cloudflare_record" "exampleAppSubDomain" {
  zone_id = var.zone_id
  name    = var.subdomain
  value   = "${fly_app.apiApp.name}.fly.dev"
  type    = "CNAME"
  proxied = true
}
