packer {
  required_version = ">= 1.7.0"
  required_plugins {
    // parallels = {
    //   version = ">= 1.0.1"
    //   source  = "github.com/hashicorp/parallels"
    // }

    vagrant = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}