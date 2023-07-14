locals {
  boot_command = length(var.boot_command) == 0 ? [
    "<wait>"
  ] : var.boot_command

  machine_name = var.machine_name == "" ? "Windows 11 ARM64" : var.machine_name
  addons       = join(",", var.addons)
}

source "parallels-iso" "image" {
  guest_os_type          = "win-11"
  parallels_tools_flavor = "win-arm"
  parallels_tools_mode   = "attach"
  prlctl = [
    ["set", "{{ .Name }}", "--efi-boot", "off"],
    ["set", "{{ .Name }}", "--efi-secure-boot", "off"],
    ["set", "{{ .Name }}", "--device-add", "cdrom", "--image", "${path.root}/unattended.iso", "--connect"],
    ["set", "{{ .Name }}", "--device-add", "cdrom", "--image", "/Applications/Parallels Desktop.app/Contents/Resources/Tools/prl-tools-win-arm.iso", "--connect"],
  ]
  prlctl_version_file       = ".prlctl_version"
  boot_command              = local.boot_command
  boot_wait                 = var.boot_wait
  cpus                      = var.machine_specs.cpus
  memory                    = var.machine_specs.memory
  disk_size                 = var.machine_specs.disk_size
  communicator              = "ssh"
  iso_checksum              = var.iso_checksum
  iso_url                   = var.iso_url
  output_directory          = "out"
  shutdown_command          = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout          = var.shutdown_timeout
  winrm_username            = "vagrant"
  winrm_password            = "vagrant"
  winrm_timeout             = "60m"
  ssh_port                  = 22
  ssh_username              = "vagrant"
  ssh_password              = "vagrant"
  ssh_timeout               = "60m"
  ssh_wait_timeout          = "60m"
  ssh_clear_authorized_keys = true
  vm_name                   = local.machine_name
}