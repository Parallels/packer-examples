packer {
  required_version = ">= 1.15.0"
  required_plugins {
    parallels = {
      version = ">= 1.2.8"
      source  = "github.com/Parallels/parallels"
    }

    vagrant = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}