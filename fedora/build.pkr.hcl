build {
  sources = [
    "source.parallels-iso.image"
  ]

  # Base System Setup
  provisioner "shell" {
    environment_vars = [
      "USERNAME=${local.username}",
      "HOME_DIR=/home/${local.username}"
    ]
    scripts = [
      "${path.root}/../scripts/fedora/base/sshd.sh",
      "${path.root}/../scripts/fedora/base/update.sh",
      "${path.root}/../scripts/fedora/base/parallels.sh",
      "${path.root}/../scripts/fedora/base/parallels_folders.sh",
    ]
    execute_command   = "echo '${local.password}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  # Conditional GUI Installation
  provisioner "shell" {
    scripts = [
      "${path.root}/../scripts/fedora/base/desktop.sh",
    ]
    execute_command = "echo '${local.password}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
    only            = var.install_desktop ? ["parallels-iso.image"] : []
  }

  # Addons Installation
  provisioner "shell" {
    environment_vars = [
      "ADDONS=${local.addons}",
      "ADDONS_DIR=${path.root}/../scripts/fedora/addons"
    ]
    scripts = [
      "${path.root}/../scripts/fedora/addons/install.sh",
    ]
    execute_command   = "echo '${local.password}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
    expect_disconnect = true
    timeout           = "3h"

    # This prevents the exit 1 error when addons = []
    except = length(var.addons) > 0 ? [] : ["parallels-iso.image"]
  }

  # Security & Cleanup
  provisioner "shell" {
    environment_vars = [
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/fedora/base/password_change.sh",
      "${path.root}/../scripts/fedora/base/cleanup.sh",
    ]
    execute_command   = "echo '${local.password}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = var.create_vagrant_box ? ["parallels-iso.image"] : []
  }
}

 