locals {
  version  = replace(var.version, ".", "_")
  hostname = var.hostname == "" ? "ubuntu_${local.version}" : var.hostname

  boot_command = length(var.isos_urls) == 0 ? [
    "<wait>e<wait><down><down><down><end><wait> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/<f10><wait>"
  ] : var.boot_command

  isos_urls = length(var.isos_urls) == 0 ? [
    "https://releases.ubuntu.com/${var.version}/ubuntu-${var.version}-live-server-arm64.iso"
  ] : var.isos_urls

  iso_checksum = var.iso_checksum == "" ? "file:https://cdimage.ubuntu.com/releases/${var.version}/release/SHA256SUMS" : var.iso_checksum
  ssh_username = var.ssh_username == "" ? var.user.username : var.ssh_username
  ssh_password = var.ssh_password == "" ? var.user.password : var.ssh_password

  username = var.create_vagrant_box ? "vagrant" : var.user.username
  password = var.create_vagrant_box ? "vagrant" : var.user.password
  encrypted_password = var.create_vagrant_box ? "$6$parallels$VXyp.NunfN8bTmRtTNYSOrWE7KHIbHrc02A/N1oQ9dpJY4xB9KQjYEp7ZL53hzGne0QpZJK7Iqs99dQ/qeb3R." : var.user.encrypted_password

  machine_name = var.machine_name == "" ? "ubuntu-${local.version}" : var.machine_name
  addons = join(",", var.addons)
}

source "parallels-iso" "image" {
  guest_os_type          = "ubuntu"
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
    "/ubuntu/user-data"          = templatefile("${path.root}/../http/ubuntu/user-data.pkrtpl.hcl", { username = "${local.username}", hostname = "${local.hostname}", password = "${local.encrypted_password}" })
    "/ubuntu/meta-data"          = templatefile("${path.root}/../http/ubuntu/meta-data.pkrtpl.hcl", { hostname = "${local.hostname}" })
    "/ubuntu/preseed-hyperv.cfg" = templatefile("${path.root}/../http/ubuntu/preseed-hyperv.cfg.pkrtpl.hcl", { username = "${local.username}", password = "${local.password}" })
    "/ubuntu/preseed.cfg"        = templatefile("${path.root}/../http/ubuntu/preseed.cfg.pkrtpl.hcl", { username = "${local.username}", password = "${local.password}" })
  }

  iso_urls         = local.isos_urls
  output_directory = "out"
  shutdown_command = "echo '${local.username}'|sudo -S shutdown -P now"
  shutdown_timeout = var.shutdown_timeout
  ssh_port         = var.ssh_port
  ssh_username     = local.ssh_username
  ssh_password     = local.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_wait_timeout = var.ssh_wait_timeout
  vm_name          = local.machine_name
}