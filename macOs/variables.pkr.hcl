variable "user" {
  type = object({
    username           = string
    password           = string
  })
  default = {
    username           = "parallels"
    password           = "parallels"
  }
}

variable "output_directory" {
  type    = string
  default = "out"
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
  default = "6m"
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

variable "create_vagrant_box" {
  type    = bool
  default = false
}