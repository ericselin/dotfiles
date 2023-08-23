terraform {
  cloud {
    organization = "ericselin"
    workspaces {
      name = "cloud"
    }
  }
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    gandi = {
      source  = "go-gandi/gandi"
      version = ">= 2.1.0"
    }
  }
}
