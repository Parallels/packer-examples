build {
  //   hcp_packer_registry {
  //     bucket_name = "parallels-kali-server-23-04-arm"
  //     description = <<EOT
  // Parallels kali Server 23.04 ARM64
  //     EOT
  //     bucket_labels = {
  //       "owner"          = "Parallels Desktop"
  //       "os"             = "kali",
  //       "kali-version" = "Lunar 23.04",
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
      "DEFAULT_USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/kali/base/update.sh",
      "${path.root}/../scripts/kali/base/install-snap.sh",
      "${path.root}/../scripts/kali/base/sshd.sh",
      "${path.root}/../scripts/kali/base/sudoers.sh",
      "${path.root}/../scripts/kali/base/systemd.sh",
      "${path.root}/../scripts/kali/base/parallels.sh",
      "${path.root}/../scripts/kali/base/apt-cleanup.sh",

    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
    ]

    scripts = [
      "${path.root}/../scripts/kali/base/vagrant.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  provisioner "file" {
    source      = "${path.root}/../scripts/kali/addons"
    destination = "/parallels-tools"
    direction   = "upload"
    except            = length(var.addons) > 0 ?  [] : ["parallels-iso.image"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
      "ADDONS=${local.addons}",
      "ADDONS_DIR=/parallels-tools/addons"
    ]
      
    scripts = [
      "${path.root}/../scripts/kali/addons/install.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
    expect_disconnect = true
    timeout           = "3h"
    except            = length(var.addons) > 0 ?  [] : ["parallels-iso.image"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/kali/base/password_change.sh",
    ]

    execute_command   = "echo 'kali' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }


  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = local.vagrant_output_dir
    vagrantfile_template = null
    except                 = !var.create_vagrant_box ?  ["parallels-iso.image"] : []
  }
}
