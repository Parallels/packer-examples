build {
  sources = [
    "source.parallels-iso.image"
  ]

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
      "HOSTNAME=${local.hostname}",
    ]
    scripts = [
      "${path.root}/../scripts/parrot-linux/base/update.sh",
      "${path.root}/../scripts/parrot-linux/base/install-snap.sh",
      "${path.root}/../scripts/parrot-linux/base/sshd.sh",
      "${path.root}/../scripts/parrot-linux/base/sudoers.sh",
      "${path.root}/../scripts/parrot-linux/base/systemd.sh",
      "${path.root}/../scripts/parrot-linux/base/parallels.sh",
      "${path.root}/../scripts/parrot-linux/base/parallels_folders.sh",
      "${path.root}/../scripts/parrot-linux/base/apt-cleanup.sh",
      "${path.root}/../scripts/parrot-linux/base/change-hostname.sh",
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
      "${path.root}/../scripts/parrot-linux/base/vagrant.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  provisioner "file" {
    source      = "${path.root}/../scripts/parrot-linux/addons"
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
      "${path.root}/../scripts/parrot-linux/addons/install.sh",
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
      "${path.root}/../scripts/parrot-linux/base/password_change.sh",
    ]

    execute_command   = "echo 'parrot-linux' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
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
