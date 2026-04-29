user = {
  username           = "parallels"
  encrypted_password = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password           = "parallels"
}
version      = "10.1"
machine_name = "OracleLinux ARM"
hostname     = "OracleLinux"
machine_specs = {
  cpus      = 2,
  memory    = 4096,
  disk_size = "65536",
}

iso_url            = "https://yum.oracle.com/ISOS/OracleLinux/OL10/u1/aarch64/OracleLinux-R10-U1-aarch64-dvd.iso"
iso_checksum       = "sha256:021cabde0d7bc9ac8f30f12e7c7b4b5a250a6994d87bb93aa93894cce8b3bc16"
addons             = []
install_desktop    = true
create_vagrant_box = false
