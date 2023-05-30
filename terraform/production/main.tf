locals {
  cf_org_name      = "ORGANIZATION"
  cf_space_name    = "prod"
  env              = "production"
  recursive_delete = true
}

module "database" {
  source = "../modules/database"

  cf_user          = var.cf_user
  cf_password      = var.cf_password
  cf_org_name      = local.cf_org_name
  cf_space_name    = local.cf_space_name
  app_name         = "clubfed"
  env              = local.env
  recursive_delete = local.recursive_delete
  rds_plan_name    = "micro-psql"
}