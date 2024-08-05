source "parallels-macvm" "image" {
  output_directory = local.output_dir
  boot_command     = local.boot_command
  boot_wait        = "${var.boot_wait}"
  shutdown_command = "sudo shutdown -h now"
  source_path      = var.macvm_path
  ssh_username     = "${local.ssh_username}"
  ssh_password     = "${local.ssh_password}"
  vm_name          = "${local.machine_name}"
}
