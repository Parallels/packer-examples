user = {
  username           = "parallels"
  encrypted_password = "$6$parallels$tb6hm4RSqzwG3j51DSzdFD7Zw3Fxy/x5aen.Yvud7IfLqarIxMEuuM8efQy0gO.pHhT.lIz9tNYoppTGBGCsB/"
  password           = "parallels"
}
version      = "10"
machine_name = "CentOS Stream 10 packer"
hostname     = "CentOS Stream"
machine_specs = {
  cpus      = 2,
  memory    = 4096,
  disk_size = "65536",
}

iso_url      = "https://mirror.stream.centos.org/10-stream/BaseOS/aarch64/iso/CentOS-Stream-10-latest-aarch64-boot.iso"
iso_checksum = "sha256:0f532ef8240d0e8529f2894cf888fbf16c5e203acc334de4c2efa6ec13aa2c2c"

addons             = ["vscode"]
install_desktop    = true
create_vagrant_box = false
