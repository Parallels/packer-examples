user = {
  username           = "parallels"
  encrypted_password = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password           = "parallels"
}
version      = "10"
machine_name = "CentOS Stream 10"
hostname     = "CentOS Stream"
machine_specs = {
  cpus      = 2,
  memory    = 4096,
  disk_size = "65536",
}

iso_url      = "https://mirror.stream.centos.org/10-stream/BaseOS/aarch64/iso/CentOS-Stream-10-latest-aarch64-boot.iso"
iso_checksum = "sha256:fbed4a9f53477e1bf94296909d1f6567b1a10266898dd74d63dd9f8a018d125c"

addons             = []
install_desktop    = true
create_vagrant_box = false
