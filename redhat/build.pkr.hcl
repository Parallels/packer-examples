build {
  sources = [
    "source.parallels-iso.image"
  ]

  provisioner "shell" {
    environment_vars = [
      "REDHAT_USERNAME=${var.redhat_username}",
      "REDHAT_PASSWORD=${var.redhat_password}",
    ]

    scripts = [
      "${path.root}/../scripts/rhel/base/subscribe.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
      "HOSTNAME=${local.hostname}",
    ]
    scripts = [
      "${path.root}/../scripts/rhel/base/init.sh",
      "${path.root}/../scripts/rhel/base/sshd.sh",
      "${path.root}/../scripts/rhel/base/parallels.sh",
      "${path.root}/../scripts/rhel/base/parallels_folders.sh",
      "${path.root}/../scripts/rhel/base/cleanup.sh",
      "${path.root}/../scripts/rhel/base/change-hostname.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    except            = var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
      "HOSTNAME=${local.hostname}",
    ]
    scripts = [
      "${path.root}/../scripts/rhel/base/desktop.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.install_desktop ? ["parallels-iso.image"] : []
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
    ]

    scripts = [
      "${path.root}/../scripts/rhel/base/vagrant.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  provisioner "file" {
    source      = "${path.root}/../scripts/rhel/addons"
    destination = "/parallels-tools"
    direction   = "upload"
    except      = length(var.addons) > 0 && (var.redhat_username != "" || var.redhat_password != "") ? [] : ["parallels-iso.image"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
      "ADDONS=${local.addons}",
      "ADDONS_DIR=/parallels-tools/addons"
    ]

    scripts = [
      "${path.root}/../scripts/rhel/addons/install.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
    expect_disconnect = true
    timeout           = "3h"
    except            = length(var.addons) > 0 && (var.redhat_username != "" || var.redhat_password != "") ? [] : ["parallels-iso.image"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/rhel/base/password_change.sh",
    ]

    execute_command   = "echo 'rhel' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  provisioner "shell" {

    scripts = [
      "${path.root}/../scripts/rhel/base/unsubscribe.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.redhat_unsubscribe ? ["parallels-iso.image"] : []
  }

  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = local.vagrant_output_dir
    vagrantfile_template = null
    except               = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }
}
