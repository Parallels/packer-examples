variable "machine_name" {
  type    = string
  default = ""
}

variable "machine_specs" {
  type = object({
    cpus      = number
    memory    = number
    disk_size = string
  })
  default = {
    cpus      = 2
    memory    = 2048
    disk_size = "65536"
  }
}

variable "boot_command" {
  type    = list(string)
  default = []
}

variable "boot_wait" {
  type    = string
  default = "20s"
}

variable "iso_url" {
  type = string
}

variable "iso_checksum" {
  type = string
}

variable "shutdown_timeout" {
  type    = string
  default = "15m"
}

variable "ssh_username" {
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

variable "output_directory" {
  type    = string
  default = ""
}

variable "output_vagrant_directory" {
  type    = string
  default = ""
}