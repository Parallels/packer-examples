locals {
  output_dir         = var.output_directory == "" ? "out" : var.output_directory
  vagrant_output_dir = var.output_vagrant_directory == "" ? "${path.root}/box/${local.machine_name}.box" : "${var.output_vagrant_directory}/box/${local.machine_name}.box"
  username           = var.create_vagrant_box ? "vagrant" : var.user.username
  password           = var.create_vagrant_box ? "vagrant" : var.user.password

  boot_command = length(var.boot_command) == 0 ? [
    "<wait>"
  ] : var.boot_command

  ipsw_url = length(var.ipsw_url) == 0 ? "https://updates.cdn-apple.com/2024SpringFCS/fullrestores/062-01897/C874907B-9F82-4109-87EB-6B3C9BF1507D/UniversalMac_14.5_23F79_Restore.ipsw" : var.ipsw_url

  ipsw_checksum = var.ipsw_checksum == "" ? "md5:a0083c0f07465a643a672c67f5a746e7" : var.ipsw_checksum
  ssh_username  = var.create_vagrant_box ? "vagrant" : var.ssh_username == "" ? var.user.username : var.ssh_username
  ssh_password  = var.create_vagrant_box ? "vagrant" : var.ssh_password == "" ? var.user.password : var.ssh_password

  machine_name = var.machine_name == "" ? "macOs-14.5_23F79" : var.machine_name
  addons       = join(",", var.addons)
  version_source = var.version == "monterey" ? "parallels-ipsw.monterey" : var.version == "ventura" ? "parallels-macvm.ventura" : var.version == "sonoma" ? "parallels-macvm.sonoma" : "parallels-macvm.sequoia"
  sources = [
    var.macvm_path == "" ? local.version_source : "parallels-macvm.image"
  ]
  vagrant_sources = [
    var.macvm_path == "" ? local.version_source : "parallels-macvm.image"
  ]
}
