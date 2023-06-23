build {
  //   hcp_packer_registry {
  //     bucket_name = "parallels-ubuntu-server-23-04-arm"
  //     description = <<EOT
  // Parallels Ubuntu Server 23.04 ARM64
  //     EOT
  //     bucket_labels = {
  //       "owner"          = "Parallels Desktop"
  //       "os"             = "Ubuntu",
  //       "ubuntu-version" = "Lunar 23.04",
  //     }

  //     build_labels = {
  //       "build-time"   = timestamp()
  //       "build-source" = basename(path.cwd)
  //     }
  //   }

  sources = [
    "source.parallels-iso.image"
  ]

  provisioner "file" {
    source      = "${path.root}/../scripts/windows/addons"
    destination = "c:\\parallels-tools"
    direction   = "upload"
    except            = length(var.addons) > 0 ?  [] : ["parallels-iso.image"]
  }

  provisioner "windows-restart" {}

  provisioner "powershell" {
    inline = [
      "powershell -NoLogo -ExecutionPolicy RemoteSigned -File \"c:\\parallels-tools\\addons\\choco\\addons.ps1\" ${local.addons}"
    ]

    elevated_password = "vagrant"
    elevated_user = "vagrant"
    execution_policy = "remotesigned"
    except            = length(var.addons) > 0 ?  [] : ["parallels-iso.image"]
  }

  // provisioner "powershell" {
  //   inline = [
  //     "winget install --id=Microsoft.VisualStudioCode -e --silent --accept-package-agreements --accept-source-agreements"
  //   ]
  //   // script = "${path.root}/../scripts/windows/addon
  //   elevated_password = "vagrant"
  //   elevated_user = "vagrant"
  //   execution_policy = "remotesigned"
  //   // execute_command = "powershell -NoLogo -ExecutionPolicy RemoteSigned -File {{ .Path }} {{ .Vars }}"
  //   except            = length(var.addons) > 0 ?  [] : ["parallels-iso.image"]
  // }

  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = "${path.root}/box/${local.machine_name}.box"
    vagrantfile_template = null
    except               = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }
}
