variable "PREFIX" {}
variable "REGION" {}
variable "ZONE1" {}
variable "ADMIN_PROJ_ID" {}
variable "ADMIN_PROJ_NAME" {}
variable "TERRA_BACKEND_BUCKET_NAME" {}
variable "INFRA_PROJ_ID" {}
variable "INFRA_PROJ_NAME" {}
variable "ORG_ID" {}
variable "FOLDER_ID" {}
variable "BILLING_ACCOUNT_ID" {}
variable "CREDS" {}
variable "OWNER" {}
variable "PROJECT" {}

variable "kube_subnet_cidr_block" {
  type = string
  default = "10.50.1.0/24"
}
