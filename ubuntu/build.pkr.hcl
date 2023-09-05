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
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/ubuntu/base/update.sh",
      "${path.root}/../scripts/ubuntu/base/sshd.sh",
      "${path.root}/../scripts/ubuntu/base/networking.sh",
      "${path.root}/../scripts/ubuntu/base/sudoers.sh",
      "${path.root}/../scripts/ubuntu/base/systemd.sh",
      "${path.root}/../scripts/ubuntu/base/parallels.sh",
      "${path.root}/../scripts/ubuntu/base/parallels_folders.sh",
      "${path.root}/../scripts/ubuntu/base/minimize.sh",
    ]

    execute_command   = "echo 'ubuntu' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]

    scripts = [
      "${path.root}/../scripts/ubuntu/base/vagrant.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  provisioner "file" {
    source      = "${path.root}/../scripts/ubuntu/addons"
    destination = "/parallels-tools"
    direction   = "upload"
    except      = length(var.addons) > 0 ? [] : ["parallels-iso.image"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
      "ADDONS=${local.addons}",
      "ADDONS_DIR=/parallels-tools/addons"
    ]

    scripts = [
      "${path.root}/../scripts/ubuntu/addons/install.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
    expect_disconnect = true
    timeout           = "3h"
    except            = length(var.addons) > 0 ? [] : ["parallels-iso.image"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/ubuntu/base/password_change.sh",
      "${path.root}/../scripts/ubuntu/base/clean_user_snap_folder.sh",
    ]

    execute_command   = "echo 'ubuntu' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }


  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = local.vagrant_output_dir
    vagrantfile_template = null
    except               = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }
}
