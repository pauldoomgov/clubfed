module "https-proxy" {
  source        = "../modules/https-proxy"
  name          = "https-proxy"
  cf_org_name   = var.cf_org_name
  cf_space_name = "${var.cf_space_name}-egress"
  client_space  = var.cf_space_name
  instances     = var.https_proxy_instances

  allowlist = {
    clubfed_deps = [
      "api.weather.gov:443",
    ],
  }
  denylist = {}
}
