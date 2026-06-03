
source "parallels-iso" "azure-linux" {

  boot_wait     = "7s"
  
  boot_command = [
    "<down><enter><wait><enter><wait><enter><wait><enter><wait><wait>",
    "<down><down><right><enter><wait><wait>",
    "<enter><wait><wait>",
    "${var.vm_username}<wait><down><wait><wait>",
    "${var.vm_password}<wait><down><wait><wait>",
    "${var.vm_password}<wait><down><wait><enter><wait><wait>",
    "<enter><wait45s>",
    "<enter><wait5>",
    "<wait10>",
    "${var.vm_username}<enter><wait>",
    "${var.vm_password}<enter>",
    "<enter>",
    "echo '${var.vm_username} ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/a<enter>",
    "${var.vm_password}<enter><wait>",
    "sudo tdnf install -y openssh-server<enter><wait>",
    "${var.vm_password}<enter><wait45s>",
    "<enter>",
    "sudo systemctl enable --now sshd<enter>"
  ] 

 // 
  parallels_tools_mode = "attach"
 
  cpus                    = var.cpu_count
  memory                  = var.memory_size
  disk_size               = var.disk_size
  guest_os_type           = "linux" 
  http_directory          = "../http/azure"
  iso_url                 = var.iso_url 
  iso_checksum            = var.iso_checksum 
  parallels_tools_flavor  = "lin-arm"
  
  ssh_username            = var.vm_username
  ssh_password            = var.vm_password
  ssh_timeout             = "20m"
  shutdown_command        = "echo '${var.vm_password}' | sudo -S shutdown -P now"
  vm_name                 = var.vm_name
}
