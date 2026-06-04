
build {
  sources = ["source.parallels-iso.azure-linux"]

  provisioner "shell" {
    scripts = [
      "../scripts/azure/parallels-tools.sh",
      "../scripts/azure/cleanup.sh"
    ]
  }
}
