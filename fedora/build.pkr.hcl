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
      "${path.root}/../scripts/fedora/base/init.sh",
      // "${path.root}/../scripts/fedora/base/install-snap.sh",
      "${path.root}/../scripts/fedora/base/sshd.sh",
      "${path.root}/../scripts/fedora/base/parallels.sh",
      "${path.root}/../scripts/fedora/base/parallels_folders.sh",
      "${path.root}/../scripts/fedora/base/cleanup.sh",
      "${path.root}/../scripts/fedora/base/change-hostname.sh",
      "${path.root}/../scripts/fedora/base/budgie-desktop.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  // provisioner "shell" {
  //   environment_vars = [
  //     "HOME_DIR=/home/${local.username}",
  //     "DEFAULT_USERNAME=${local.username}",
  //   ]

  //   scripts = [
  //     "${path.root}/../scripts/fedora/base/vagrant.sh",
  //   ]

  //   execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
  //   expect_disconnect = true
  //   except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  // }

  // provisioner "file" {
  //   source      = "${path.root}/../scripts/fedora/addons"
  //   destination = "/parallels-tools"
  //   direction   = "upload"
  //   except      = length(var.addons) > 0 ? [] : ["parallels-iso.image"]
  // }

  // provisioner "shell" {
  //   environment_vars = [
  //     "HOME_DIR=/home/${local.username}",
  //     "USERNAME=${local.username}",
  //     "ADDONS=${local.addons}",
  //     "ADDONS_DIR=/parallels-tools/addons"
  //   ]

  //   scripts = [
  //     "${path.root}/../scripts/fedora/addons/install.sh",
  //   ]

  //   execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
  //   expect_disconnect = true
  //   timeout           = "3h"
  //   except            = length(var.addons) > 0 ? [] : ["parallels-iso.image"]
  // }

  // provisioner "shell" {
  //   environment_vars = [
  //     "HOME_DIR=/home/${local.username}",
  //     "USERNAME=${local.username}",
  //   ]
  //   scripts = [
  //     "${path.root}/../scripts/fedora/base/password_change.sh",
  //   ]

  //   execute_command   = "echo 'fedora' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
  //   expect_disconnect = true
  // }


  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = local.vagrant_output_dir
    vagrantfile_template = null
    except               = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }
}
