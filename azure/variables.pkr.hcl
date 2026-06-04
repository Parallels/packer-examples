
variable "vm_username" {
  type        = string
}

variable "vm_password" {
  type        = string
  sensitive   = true
}

variable "cpu_count" {
  type        = number
}

variable "memory_size" {
  type        = number
}

variable "disk_size" {
  type        = number
}

variable "iso_url" {
  type        = string
}

variable "iso_checksum" {
  type        = string
}

variable "vm_name" {
  type        = string
}