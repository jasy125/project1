variable "region" {
  default = "europe-west2"
}

variable "region_zone" {
  default = "europe-west2-c"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
  default = "<ID of the Project>"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "~/.gcp/account.json"
}

variable "vmname" {
  description = "Name of the VM to be created"
  default = "terraform-instance"
}

variable "sshuser" {
  description = "Owner of the ssh key generated"
  default = "root"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "~/.ssh/gcloud_id_rsa"
}

variable "dbname" {
  description = "The Name of the New Database"
  default = "world"
}

variable "importdb" {
  description = "Path to location of .sql file to be imported"
  default = "postgres/world.sql"
}

variable "dbquery" {
   description = "The Query you wish to run against the database"
   default = "'select * from city limit 10;'"
}

