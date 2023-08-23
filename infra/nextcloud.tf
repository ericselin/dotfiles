resource "hcloud_server" "nextcloud_srv" {
  name               = "nextcloud"
  location           = "hel1"
  image              = "ubuntu-22.04"
  server_type        = "cx31"
  backups            = true
  delete_protection  = true
  rebuild_protection = true
  ssh_keys           = ["yubikey"]
  user_data          = <<-EOT
    #!/bin/bash
    curl -fsSL https://get.docker.com | sudo sh
    sudo docker run -d \
      --sig-proxy=false \
      --name nextcloud-aio-mastercontainer \
      --restart always \
      --publish 80:80 \
      --publish 8080:8080 \
      --publish 8443:8443 \
      --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
      --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    nextcloud/all-in-one:latest
    EOT
  firewall_ids       = [hcloud_firewall.nextcloud_fw.id]
}

import {
  to = gandi_livedns_record.nextcloud_dns
  id = "ericselin.dev/cloud/A"
}

resource "gandi_livedns_record" "nextcloud_dns" {
  zone = data.gandi_domain.esdev.id
  name = "cloud"
  type = "A"
  ttl  = 10800
  values = [
    hcloud_server.nextcloud_srv.ipv4_address
  ]
}

data "gandi_domain" "esdev" {
  name = "ericselin.dev"
}

output "primary_ip" {
  value = hcloud_server.nextcloud_srv.ipv4_address
}

resource "hcloud_ssh_key" "yubikey" {
  name       = "yubikey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCryjqsXgrOfqxXR73snoWYi6P4+P0ZgMlakghx/C2UV4uV9uJY3ga1xkpGu6sDUwTcvLLg2f8Hj2SNJm4akVFkOHSQu2+Xu8+somb5hulNr9je62tHEtlFAYEjEspjoR/goFVelpyfZP3W9T43+ZTvS5X1HgjfU3C+EfBQhUusNY0fMDhJcRORN689RvDu9hnAB+7AUjeMwkHN6oGsGVs+XpQ4J2oWsi5gGJVEicAk4quTKMcrS1lWT7amvPzjnjKwzsVilSya+G6uCBtUaZs63ndL2XwU1pKzdBnZvgKR2oVlQk4K6V6RvWyK+46fMjtg26+OnmqehN02qZ+R6BhivPeYtHr2l8M3p20WLy2xlARkI97ergG0x61vaDCk5D2pvrk5Epve6NcO+ONLcon5Un8ZNWKB2HLdlMgkWmELfdyC7V3jo4RLWcNChCaYWnnxDP8rq4qHjhYK6PDpraai2GZdvVmlH3+95mM2xP6jBv6XdMkwZAJzkWLrKJPC1T2sc5q3Sk4A4BxLHByL12zjKrEQND0uCjXG+k3ZpiS5VlXLqYB7hjvxWEKqcruBqx6bwV7yfShHd3K88zCMO0D/iNV9B0xRQ5FSw8fRkHHh92G/Tk7LQ+4fmttqAruTetSlEz0Pszll0pDZR6arH3NCscWYDhGJBKWgNBE4hqoZDw== cardno:13 703 670"
}

resource "hcloud_firewall" "nextcloud_fw" {
  name = "nextcloud"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "udp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "8443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "udp"
    port      = "8443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

}

variable "hcloud_token" { sensitive = true }
variable "gandi_apikey" { sensitive = true }
provider "hcloud" {
  token = var.hcloud_token
}
provider "gandi" {
  key = var.gandi_apikey
}
