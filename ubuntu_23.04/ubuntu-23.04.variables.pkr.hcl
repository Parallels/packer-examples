variable "user_username" {
  type    = string
  default = "cjlapao"
}

variable "hostname" {
  type    = string
  default = "ubuntu"
}

variable "password" {
  type = string
  default = "ubuntu"
}

variable "install_desktop" {
  type    = bool
  default = false
}

variable "install_vscode" {
  type    = bool
  default = false
}

variable "install_vscode_server" {
  type    = bool
  default = false
}

variable "create_vagrant_box" {
  type    = bool
  default = false
}