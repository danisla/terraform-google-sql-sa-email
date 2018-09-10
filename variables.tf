variable "instance" {
  description = "The name of the Cloud SQL instance"
}

variable "project" {
  description = "The name of the Google Cloud Platform project where the instance resides. If not given, the default project from the output of 'gcloud config get-value project' is used."
  default     = ""
}
