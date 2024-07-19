user = {
  username              = "parallels"
  encrypted_password    = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password              = "parallels",
  force_password_change = true,
}

machine_name = "ubuntu_ai"
hostname     = "ubuntu-ai"
machine_specs = {
  cpus      = 2,
  memory    = 8192,
  disk_size = "65536",
}
iso_url      = ""
iso_checksum = ""
addons = [
  "desktop"
]
create_vagrant_box = false