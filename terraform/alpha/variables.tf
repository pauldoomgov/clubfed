variable "cf_user" {
  type        = string
  description = "cloud.gov deployer account user"
}

variable "cf_password" {
  type        = string
  description = "secret; cloud.gov deployer account password"
  sensitive   = true
}

variable "cf_org_name" {
  type        = string
  description = "name of the organization to configure"
}

variable "cf_space_name" {
  type        = string
  description = "name of the space to configure"
}

variable "https_proxy_instances" {
  type    = number
  default = 1
}
