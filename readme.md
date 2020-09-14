# Terraform Build

#### Table of Contents

1. [Description](#description)
2. [Setup](#setup)
    * [What Happens](#what-happens)
    * [Setup requirements](#setup-requirements)
    * [Getting Started](#getting-started)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This Terraform Task will spin up a GCP compute engine and install postgresql, import a database, run your query against it. It will also install docker and open it to the world on port 80.

## Setup

### What Happens

* Sets a Static address
* Sets firewall rules for port 80 and 443 and allows ping
* Sets up a new google cloud instance
  - assigns our ssh key to the instance
  - Copies our db and installer script to the instance
  - Modifies and runs the installer script

### Setup Requirements

* Google cloud account
* Terraform
* SSH Key pair

### Getting Started

You will need to modify the variables.tf file to contain your own variables

Variables 
  - region
  - region_zone
  - project_name
  - credentials_file_path
  - vmname
  - sshuser
  - public_key_path
  - private_key_path
  - dbname
  - importdb
  - dbquery

  Descriptions on what each of these are is contained within the variables.tf

Modify the query in the dockernginx.sh file on line 40 to output your own query

## Usage

Download the project 1 
Modify the variables.tf 
Run terraform plan
Run terraform apply

#### Required

GCP Account json file : This is downloaded from your google cloud account when creating the project

GCP Project ID : The Id of your project

## Limitations

You need a GCP account to run this
This is designed to run on debian/ubuntu servers

## Development

First Build with terraform on GCP
Look into building the docker container on Kubernetes
Possibly move the postgres to gcp cloud SQL
Modify script to include centos/rhel or create separate script and call based on selection of os

## Release Notes/Contributors/Etc

Sample DB Source

https://www.postgresql.org/ftp/projects/pgFoundry/dbsamples/world/dbsamples-0.1/

References

https://www.terraform.io/docs/providers/google/
https://www.postgresql.org/ftp/projects/pgFoundry/dbsamples/world/dbsamples-0.1/
https://github.com/terraform-providers/terraform-provider-oci/issues/781

Contributers 

   - Jasy125
