variable "instance" {}

variable "region" {
  default = "us-central1"
}

provider "google" {
  region = "${var.region}"
}

data "google_client_config" "current" {}

module "sql_sa_email" {
  source   = "../../"
  instance = "${var.instance}"
  project  = "${data.google_client_config.current.project}"
}

output "sa_email" {
  value = "${module.sql_sa_email.sa_email}"
}
