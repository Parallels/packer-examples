user = {
  username           = "parallels"
  encrypted_password = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password           = "parallels"
}
version      = "44"
machine_name = "fedora-44 ARM"
hostname     = "fedora-Server"
machine_specs = {
  cpus      = 2,
  memory    = 4096,
  disk_size = "65536",
}
iso_url            = "https://download.fedoraproject.org/pub/fedora/linux/releases/44/Server/aarch64/iso/Fedora-Server-dvd-aarch64-44-1.7.iso"
iso_checksum       = "sha256:ba8372682294d0d76f79427cae1273d36891b192ac9bf0f0f9de4e97a7cbe218"


addons             = []
install_desktop    = true
create_vagrant_box = false
