locals {
  output_dir         = var.output_directory == "" ? "out" : var.output_directory
  vagrant_output_dir = var.output_vagrant_directory == "" ? "${path.root}/box/${local.machine_name}.box" : "${var.output_vagrant_directory}/box/${local.machine_name}.box"
  username           = var.create_vagrant_box ? "vagrant" : var.user.username
  password           = var.create_vagrant_box ? "vagrant" : var.user.password

  boot_command = length(var.boot_command) == 0 ? [
    "<wait><enter><wait2s><enter><wait20s>",               # Wait for boot
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait5s>",  # Select country
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait1s>",  #Select language
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait30s>", #Accessibility
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait2s>",  #Data and Privacy
    "<tab><tab><tab><spacebar><wait2s>",                   #Migration assistant
    "<leftShiftOn><tab><tab><leftShiftOff><spacebar><wait2s><tab><spacebar><wait5s>",
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait2s><tab><spacebar><wait2s>",                           #Terms and Conditions
    "${local.username}<tab><tab>${local.password}<tab>${local.password}<tab><tab><tab><spacebar><wait2m>", #Create a computer account
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait2s><tab><spacebar><wait2s>",                           #Enable location services
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait20s>",                                                 #Select your time zone
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait2s>",                                                  #Analytics
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait20s>",                                                 #Screen Time
    "<tab><spacebar><tab><tab><tab><spacebar><wait10s>",                                                   #Siri
    "<leftShiftOn><tab><leftShiftOff><spacebar><wait60s>",                                                 #Choose your look
    "",
    "<leftCtrlOn><f7><leftCtrlOff><wait2s>",                                        #enable keyboard navigation
    "<leftSuperOn><spacebar><leftSuperOff>System<spacebar>Settings<enter><wait5s>", #open system settings
    "Gen<tab><tab><tab><tab><tab><tab><tab><tab><spacebar><wait5s>",                #Sharing screen
    "<tab><tab><tab><tab><tab><tab><tab><tab><spacebar><wait5s>",                   #turn on remote login
    "<tab><spacebar>",                                                              #open dialog box
    "<tab><spacebar><tab><up><tab><tab><tab><tab><spacebar><wait5s>",               #Done
    "",
    "<leftSuperOn><spacebar><leftSuperOff>terminal<enter><wait10s>",       #open terminal
    "sudo visudo /private/etc/sudoers.d/${local.username}<enter><wait2s>", #open vim
    "${local.password}<enter><wait2s>",                                    #password
    "i<wait>${local.username} ALL = (ALL) NOPASSWD: ALL",
    "<esc>:wq<enter><wait2s>",                                                                                                           #save and quit
    "NONINTERACTIVE=1 /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"<enter><wait3m>", #install homebrew
    "(echo; echo 'eval \"$(/opt/homebrew/bin/brew shellenv)\"') >> /Users/parallels/.zprofile<enter><wait5s>",
    "eval \"$(/opt/homebrew/bin/brew shellenv)\"<enter><wait5s>",

    "sudo /Volumes/Parallels\\ Tools/Install.app/Contents/MacOS/PTIAgent<enter><wait2m>", #install parallels tools and restart
    "<enter><wait5s><enter>"                                                              #restart
  ] : var.boot_command

  ipsw_url = length(var.ipsw_url) == 0 ? "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/042-01877/2F49A9FE-7033-41D0-9D0C-64EFCE6B4C22/UniversalMac_13.4.1_22F82_Restore.ipsw" : var.ipsw_url

  ipsw_checksum = var.ipsw_checksum == "" ? "md5:acd17423a6de261121454513f0a2b814" : var.ipsw_checksum
  ssh_username  = var.create_vagrant_box ? "vagrant" : var.ssh_username == "" ? var.user.username : var.ssh_username
  ssh_password  = var.create_vagrant_box ? "vagrant" : var.ssh_password == "" ? var.user.password : var.ssh_password

  machine_name = var.machine_name == "" ? "macOs-13.4.1" : var.machine_name
  addons       = join(",", var.addons)
  sources = [
    var.macvm_path == "" ? "parallels-ipsw.image" : "parallels-macvm.image"
  ]
  vagrant_sources = [
    var.macvm_path == "" ? "parallels-ipsw.image" : "parallels-macvm.image"
  ]
}

source "parallels-ipsw" "image" {
  output_directory = local.output_dir
  boot_command     = local.boot_command
  boot_wait        = "${var.boot_wait}"
  shutdown_command = "sudo shutdown -h now"
  ipsw_url         = local.ipsw_url
  ipsw_checksum    = local.ipsw_checksum
  ssh_username     = "${local.ssh_username}"
  ssh_password     = "${local.ssh_password}"
  vm_name          = "${local.machine_name}"
  cpus             = "${var.machine_specs.cpus}"
  memory           = "${var.machine_specs.memory}"
}

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
