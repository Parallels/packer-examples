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

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${var.user_username}",
      "username=${var.user_username}",
    ]
    scripts = [
      "${path.root}/scripts/update.sh",
      "${path.root}/scripts/sshd.sh",
      "${path.root}/scripts/networking.sh",
      "${path.root}/scripts/sudoers.sh",
      "${path.root}/scripts/systemd.sh",
      "${path.root}/scripts/parallels.sh",
      "${path.root}/scripts/parallels_folders.sh",
      "${path.root}/scripts/minimize.sh",
      "${path.root}/scripts/password_change.sh",
    ]

    execute_command   = "echo 'ubuntu' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${var.user_username}",
    ]
    scripts = [
      "${path.root}/scripts/vagrant.sh",
    ]

    execute_command   = "echo 'ubuntu' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except = var.create_vagrant_box ? [] : ["sources.parallels-iso.image"]
  }


  provisioner "file" {
    destination = "/parallels-tools/scripts/"
    source      = "${path.root}/scripts/"
    direction   = "upload"
  }

  provisioner "file" {
    destination = "/parallels-tools/files/"
    source      = "${path.root}/files/"
    direction   = "upload"
  }


  // provisioner "shell" {
  //   environment_vars = [
  //       "HOME_DIR=/home/ubuntu"
  //     ]
  //   scripts = [
  //     "${path.root}/scripts/addons/desktop.sh",
  //   ]

  //   execute_command   = "echo 'ubunut' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
  //   expect_disconnect = true
  //   except = var.install_desktop ? [] : ["sources.parallels-iso.image"]
  // }


  // provisioner "shell" {
  //   environment_vars = [
  //       "HOME_DIR=/home/ubuntu"
  //     ]
  //   scripts = [
  //     "${path.root}/scripts/addons/visual_studio_code.sh",
  //   ]

  //   execute_command   = "echo 'ubuntu' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
  //   expect_disconnect = true
  //   except = var.install_vscode || var.install_vscode_server ? [] : ["sources.parallels-iso.image"]
  // }

  //   provisioner "shell" {
  //   environment_vars = [
  //       "HOME_DIR=/home/ubuntu"
  //     ]
  //   scripts = [
  //     "${path.root}/scripts/addons/visual_studio_code.sh",
  //   ]

  //   execute_command   = "echo 'ubuntu' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
  //   expect_disconnect = true
  //   except = var.install_vscode_server ? [] : ["sources.parallels-iso.image"]
  // }

  // post-processor "vagrant" {
  //   compression_level    = 9
  //   keep_input_artifact  = false
  //   output               = "./builds/ubuntu.{{ .Provider }}.box"
  //   vagrantfile_template = null
  // }
}
