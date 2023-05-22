source "parallels-iso" "image" {
  guest_os_type          = "ubuntu"
  parallels_tools_flavor = "lin-arm"
  parallels_tools_mode   = "upload"
  prlctl = [
    ["set", "{{ .Name }}", "--efi-boot", "off"]
  ]
  prlctl_version_file = ".prlctl_version"
  boot_command = [
    "<wait>e<wait><down><down><down><end><wait> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/<f10><wait>"
  ]
  boot_wait      = "10s"
  cpus           = 2
  communicator   = "ssh"
  disk_size      = "65536"
  floppy_files   = null
  iso_checksum   = "file:https://cdimage.ubuntu.com/releases/23.04/release/SHA256SUMS"
  // http_directory = "${path.root}/http"
  http_content = {
    "/ubuntu/meta-data" = "instance-id: ubuntu_23.04\nlocal-hostname: ubuntu_23.04\n"
    "/ubuntu/user-data" = templatefile("${path.root}/http/ubuntu/user-data.pkrtpl.hcl", { username = var.user_username})
  }
  iso_urls = [
    "https://cdimage.ubuntu.com/releases/23.04/release/ubuntu-23.04-live-server-arm64.iso"
  ]
  memory           = 2048
  output_directory = "ubuntu-parallels"
  shutdown_command = "echo 'ubuntu'|sudo -S shutdown -P now"
  shutdown_timeout = "15m"
  ssh_password     = "ubuntu"
  ssh_port         = 22
  ssh_timeout      = "60m"
  ssh_username     = "ubuntu"
  ssh_wait_timeout = "10000s"
  vm_name          = "ubuntu_23.04"
}