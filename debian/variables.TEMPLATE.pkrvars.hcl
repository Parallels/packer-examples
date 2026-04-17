user = {
  username              = "parallels"
  encrypted_password    = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password              = "parallels",
  force_password_change = true,
}
version      = "13.4.0"
machine_name = "debian_13.4.0"
hostname     = "debian-13.4.0"
machine_specs = {
  cpus      = 2,
  memory    = 2048,
  disk_size = "65536",
}
iso_url      = "https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-13.4.0-arm64-netinst.iso"
iso_checksum = "sha256:c31f8534597df52bd310f716d271bda30a1f58e6ff8fd9e8254eba66776c42d9"
addons = [
  "desktop"
]
create_vagrant_box = false