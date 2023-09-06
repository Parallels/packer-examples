locals {
  output_dir         = var.output_directory == "" ? "out" : var.output_directory
  vagrant_output_dir = var.output_vagrant_directory == "" ? "${path.root}/box/${local.machine_name}.box" : "${var.output_vagrant_directory}/box/${local.machine_name}.box"

  version  = replace(var.version, ".", "_")
  hostname = var.hostname == "" ? "fedora_${local.version}" : var.hostname

  boot_command = length(var.boot_command) == 0 ? [
    "<wait>",
    "<up>e<wait>",
    // "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<down><down><end> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora/ks.cfg<F10><wait>"
  ] : var.boot_command

  iso_url = var.iso_url == "" ? "https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/aarch64/iso/Fedora-Server-dvd-aarch64-38-1.6.iso" : var.iso_url

  iso_checksum = var.iso_checksum == "" ? "file:https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/aarch64/iso/Fedora-Server-38-1.6-aarch64-CHECKSUM" : var.iso_checksum
  ssh_username = var.create_vagrant_box ? "vagrant" : var.ssh_username == "" ? var.user.username : var.ssh_username
  ssh_password = var.create_vagrant_box ? "vagrant" : var.ssh_password == "" ? var.user.password : var.ssh_password

  username           = var.create_vagrant_box ? "vagrant" : var.user.username
  password           = var.create_vagrant_box ? "vagrant" : var.user.password
  encrypted_password = var.create_vagrant_box ? "$6$parallels$VXyp.NunfN8bTmRtTNYSOrWE7KHIbHrc02A/N1oQ9dpJY4xB9KQjYEp7ZL53hzGne0QpZJK7Iqs99dQ/qeb3R." : var.user.encrypted_password

  machine_name = var.machine_name == "" ? "Fedora Server ${local.version}" : var.machine_name
  addons       = join(",", var.addons)
}

source "parallels-iso" "image" {
  guest_os_type          = "fedora-core"
  parallels_tools_flavor = "lin-arm"
  parallels_tools_mode   = "upload"
  prlctl = [
    ["set", "{{ .Name }}", "--efi-boot", "off"]
  ]
  prlctl_version_file = ".prlctl_version"
  boot_command        = local.boot_command
  boot_wait           = var.boot_wait
  cpus                = var.machine_specs.cpus
  memory              = var.machine_specs.memory
  disk_size           = var.machine_specs.disk_size
  communicator        = "ssh"
  floppy_files        = null
  iso_checksum        = local.iso_checksum
  http_content = {
    "/fedora/ks.cfg" = templatefile("${path.root}/../http/fedora/ks.cfg.pkrtpl.hcl", { username = "${local.username}", password = "${local.password}", hostname = "${local.hostname}" })
  }

  iso_url          = local.iso_url
  output_directory = local.output_dir
  shutdown_command = "echo '${local.username}' | sudo -S /sbin/halt -h -p"
  shutdown_timeout = var.shutdown_timeout
  ssh_port         = var.ssh_port
  ssh_username     = local.ssh_username
  ssh_password     = local.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_wait_timeout = var.ssh_wait_timeout
  vm_name          = local.machine_name
}