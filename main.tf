# Creds to connect to google

provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_name
  region      = var.region
  zone        = var.region_zone
}

// Set a Static Address
resource "google_compute_address" "static" {
  name = "ipv4-address"
}

// create our vm
resource "google_compute_instance" "vm_instance" {
  name         = var.vmname
  machine_type = "f1-micro"
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  
  // Add our ssh key to this host
  metadata = {
    sshKeys = "${var.sshuser}:${file(var.public_key_path)}"
  }
  
  // Copy the .sql file to the host
  provisioner "file" {
    source = var.importdb
    destination = "/tmp/postgres.sql"
    connection {
            type = "ssh"
            user = var.sshuser
            private_key = file(var.private_key_path)
            host = google_compute_address.static.address
            timeout = "2m"
        }
  }

  // Copy bash Script to server
  provisioner "file" {
    source      = "scripts/installer.sh"
    destination = "/tmp/installer.sh"
    connection {
            type = "ssh"
            user = var.sshuser
            private_key = file(var.private_key_path)
            host = google_compute_address.static.address
            timeout = "2m"
        }
  }

   // Run Installer Script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installer.sh",
      "sudo /tmp/installer.sh ${var.dbname} ${"${var.dbquery}"}",
    ]
    connection {
            type = "ssh"
            user = var.sshuser
            private_key = file(var.private_key_path)
            host = google_compute_address.static.address
            timeout = "2m"
        }
  }
}

// Set firewall rules
resource "google_compute_firewall" "default" {
  name    = "firewall"
  network = "default"
 
  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }
 
  allow {
    protocol = "icmp"
  }
}

// Get IP of the machine and print to screen when complete
output "ip" {
  value = "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
}
