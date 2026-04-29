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
iso_checksum = "sha256:c898320ca9bc456fd1164499236a12d704fa0b0ddb6e255c2c7a7dd1ace3499a"

addons             = []
install_desktop    = true
create_vagrant_box = false
