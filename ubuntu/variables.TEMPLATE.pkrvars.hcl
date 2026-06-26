user = {
  username              = "parallels"
  encrypted_password    = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password              = "parallels",
  force_password_change = true,
}
version      = "26.04"
machine_name = "ubuntu_26.04"
hostname     = "ubuntu-26.04"
machine_specs = {
  cpus      = 2,
  memory    = 4096,
  disk_size = "65536",
}
iso_url      = "https://cdimage.ubuntu.com/releases/26.04/release/ubuntu-26.04-live-server-arm64.iso"
iso_checksum = "sha256:c9aa567e6560b2eddae3af03fc686002e35b6fee96f97fd5df3271e846439fdd"
addons = [
  "desktop"
]
create_vagrant_box = false
