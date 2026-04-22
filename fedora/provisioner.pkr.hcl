locals {
  output_dir         = var.output_directory == "" ? "out" : var.output_directory
  vagrant_output_dir = var.output_vagrant_directory == "" ? "${path.root}/box/${local.machine_name}.box" : "${var.output_vagrant_directory}/box/${local.machine_name}.box"
  version            = replace(var.version, ".", "-")
  hostname           = var.hostname == "" ? "fedora-${local.version}" : var.hostname

  #  Boot Command for Kickstart
  boot_command = [
    "<wait>",
    "<up>e<wait>",
    "<down><down><end> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora/ks.cfg <F10><wait>"
  ]

  ssh_username = var.create_vagrant_box ? "vagrant" : var.ssh_username == "" ? var.user.username : var.ssh_username
  ssh_password = var.create_vagrant_box ? "vagrant" : var.ssh_password == "" ? var.user.password : var.ssh_password
  username     = var.create_vagrant_box ? "vagrant" : var.user.username
  password     = var.create_vagrant_box ? "vagrant" : var.user.password
  machine_name = var.machine_name == "" ? "fedora-server-${local.version}" : var.machine_name
  addons       = join(",", var.addons)
  # Standard Fedora Server environment group
  ks_package_env = "@^server-product-environment"
}

source "parallels-iso" "image" {
  vm_name                = "${local.machine_name}"
  guest_os_type          = "fedora-core"
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
  iso_checksum        = var.iso_checksum
  iso_url             = var.iso_url

  http_content = {
    "/fedora/ks.cfg" = templatefile("${path.root}/../http/fedora/ks.cfg.pkrtpl.hcl", {
      username = "${local.username}",
      password = "${local.password}",
      hostname = "${local.hostname}",
      package  = "${local.ks_package_env}"
    })
  }

  output_directory = local.output_dir
  shutdown_command = "echo '${local.password}' | sudo -S -E /sbin/halt -p"
  ssh_password     = local.ssh_password
  ssh_username     = local.ssh_username
  ssh_timeout      = "30m"
}

