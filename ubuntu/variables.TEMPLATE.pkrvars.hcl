user = {
  username              = "parallels"
  encrypted_password    = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password              = "parallels",
  force_password_change = true,
}
version      = "25.10"
machine_name = "ubuntu_25.10"
hostname     = "ubuntu-25.10"
machine_specs = {
  cpus      = 2,
  memory    = 2048,
  disk_size = "65536",
}
iso_url      = "/Users/zayaan.dulmeer/Downloads/ubuntu-25.10-live-server-arm64.iso"
iso_checksum = "sha256:ecf579664c0be9e4a68ae7b617399ce943c2dee49eb1fcc6702a5671a4f88320"
addons = [
  "desktop"
]
create_vagrant_box = false