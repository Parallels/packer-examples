// Variables for the macOS Parallels Packer build
// Options are monterey, ventura, sonoma, sequoia, sequoia_15.x

variable "version" {
  type    = string
  default = "sonoma"
}
// Any future versions of macOS should be added here.
// if there is a change in installation process, a new provisioner file should be created
// and the variable should be updated accordingly.
variable "os_versions_to_source_map" {
  type = map(string)
  default = {
    "monterey" = "parallels-ipsw.monterey"
    "ventura" = "parallels-ipsw.ventura"
    "sonoma" = "parallels-ipsw.sonoma"
    "sequoia" = "parallels-ipsw.sequoia_15_1_to_3"
    "sequoia_15.1" = "parallels-ipsw.sequoia_15_1_to_3"
    "sequoia_15.2" = "parallels-ipsw.sequoia_15_1_to_3"
    "sequoia_15.3" = "parallels-ipsw.sequoia_15_1_to_3"
    "sequoia_15.4" = "parallels-ipsw.sequoia_15_3_plus"
    "sequoia_15.5" = "parallels-ipsw.sequoia_15_3_plus"
  }
}

variable "user" {
  type = object({
    username = string
    password = string
  })
  default = {
    username = "parallels"
    password = "parallels"
  }
}

variable "output_directory" {
  type    = string
  default = "out"
}

variable "output_vagrant_directory" {
  type    = string
  default = ""
}

variable "machine_name" {
  type    = string
  default = ""
}

variable "machine_specs" {
  type = object({
    cpus   = number
    memory = number
  })
  default = {
    cpus   = 4
    memory = 8192
  }
}

variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = "1s"
}

variable "macvm_path" {
  type    = string
  default = ""
}

variable "ipsw_url" {
  type    = string
  default = ""
}

variable "ipsw_checksum" {
  type    = string
  default = ""
}

variable "ssh_username" {
  type    = string
  default = ""
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "addons" {
  type    = list(string)
  default = []
}

variable "install_homebrew" {
  type    = bool
  default = false
}

variable "create_vagrant_box" {
  type    = bool
  default = false
}

