user = {
  username              = "parallels"
  encrypted_password    = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password              = "parallels",
  force_password_change = true,
}
version      = "22.04.3"
machine_name = "ubuntu_22.04_LTS"
hostname     = "ubuntu-22.04"
machine_specs = {
  cpus      = 2,
  memory    = 2048,
  disk_size = "65536",
}
iso_url      = ""
iso_checksum = ""
addons = [
  "desktop"
]
create_vagrant_box = false