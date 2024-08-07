// Variables for the macOS Parallels Packer build
// Options are macos_12, macos_13, macos_14, macos_15
variable "version" {
  type    = string
  default = "sonoma"
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

