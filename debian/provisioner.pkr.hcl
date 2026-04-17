locals {
  output_dir         = var.output_directory == "" ? "out" : var.output_directory
  vagrant_output_dir = var.output_vagrant_directory == "" ? "${path.root}/box/${local.machine_name}.box" : "${var.output_vagrant_directory}/box/${local.machine_name}.box"

  version  = replace(var.version, ".", "_")
  hostname = var.hostname == "" ? "debian_${local.version}" : var.hostname
  
boot_command = [
  "<wait10s>e<wait>",
  "<down><down><down><end>",
  " auto=true",
  " priority=critical",
  " netcfg/choose_interface=auto",
  " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian/preseed.cfg",
  " --- ",
  "<f10>"
]

  isos_url = var.iso_url == "" ? "https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-${var.version}-arm64-netinst.iso" : var.iso_url

  iso_checksum = var.iso_checksum == "" ? "file:https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/SHA256SUMS" : var.iso_checksum
  ssh_username = var.create_vagrant_box ? "vagrant" : var.ssh_username == "" ? var.user.username : var.ssh_username
  ssh_password = var.create_vagrant_box ? "vagrant" : var.ssh_password == "" ? var.user.password : var.ssh_password

  username              = var.create_vagrant_box ? "vagrant" : var.user.username
  password              = var.create_vagrant_box ? "vagrant" : var.user.password
  force_password_change = var.create_vagrant_box ? false : var.user.force_password_change
  encrypted_password    = var.create_vagrant_box ? "$6$parallels$VXyp.NunfN8bTmRtTNYSOrWE7KHIbHrc02A/N1oQ9dpJY4xB9KQjYEp7ZL53hzGne0QpZJK7Iqs99dQ/qeb3R." : var.user.encrypted_password

  machine_name = var.machine_name == "" ? "debian-${local.version}" : var.machine_name
  addons       = join(",", var.addons)
}

source "parallels-iso" "image" {
  guest_os_type          = "debian"
  parallels_tools_flavor = "lin-arm"
  parallels_tools_mode   = "upload"
  prlctl = [
    ["set", "{{ .Name }}", "--efi-boot", "on"]
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
  iso_url             = local.isos_url

  http_content = {
    "/debian/preseed.cfg" = templatefile("${path.root}/../http/debian/preseed.cfg.pkrtpl.hcl", { 
        username = "${local.username}", 
        password = "${local.password}" 
    })
  }
  output_directory = local.output_dir
  shutdown_command = "sudo -n poweroff"
  shutdown_timeout = var.shutdown_timeout
  ssh_port         = var.ssh_port
  ssh_username     = local.ssh_username
  ssh_password     = local.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_wait_timeout = var.ssh_wait_timeout
  vm_name          = local.machine_name
}