build {
  sources = [
    "source.parallels-iso.image"
  ]

  ## Register system with Red Hat for access to online repos.
  provisioner "shell" {
    environment_vars = [
      "REDHAT_USERNAME=${var.redhat_username}",
      "REDHAT_PASSWORD=${var.redhat_password}",
    ]

    scripts = [
      "${path.root}/../scripts/rhel/base/subscribe.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    except            = var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
  }

  ## Miscellaneous setup items
  provisioner "shell" {
    scripts = [
      "${path.root}/../scripts/rhel/base/tmpdir.sh",
      "${path.root}/../scripts/rhel/base/sshd.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = false
  }

  ## Update all OS Packages
  ## Requires Red Hat credentials
  provisioner "shell" {
    scripts = [
      "${path.root}/../scripts/rhel/base/update.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    except            = var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
    expect_disconnect = true
  }

  ## Install Parallels Tools
  ## Requires Red Hat credentials, because the installer needs to be able to install prerequisites.
  ## Wait before connecting because of 'reboot' in previous provisioner.
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/rhel/base/parallels.sh",
      "${path.root}/../scripts/rhel/base/parallels_folders.sh",   # for Addons, not related to Parallels or Parallels Tools
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    except            = var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
    expect_disconnect = false
    pause_before      = "30s"
  }

  ## Miscellaneous OS Cleanup
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
      "HOSTNAME=${local.hostname}",
    ]
    scripts = [
      "${path.root}/../scripts/rhel/base/cleanup.sh",
      "${path.root}/../scripts/rhel/base/change-hostname.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    except            = var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
    expect_disconnect = true
  }

  ## Install a Graphical Desktop
  ## Requires Red Hat credentials
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
    except            = !var.install_desktop || var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
  }

  ## Install the insecure Vagrant ssh key, if we're building a Vagrant box
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]

    scripts = [
      "${path.root}/../scripts/rhel/base/vagrant_ssh_key.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  ## Copy addon scripts to system
  provisioner "file" {
    source      = "${path.root}/../scripts/rhel/addons"
    destination = "/parallels-tools"
    direction   = "upload"
    except      = length(var.addons) > 0 && (var.redhat_username != "" || var.redhat_password != "") ? [] : ["parallels-iso.image"]
  }

  ## Add the requested addons (run each script)
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

  ## Force the default user to reset their password
  ## Skip if we are building a Vagrant box
  provisioner "shell" {
    environment_vars = [
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/rhel/base/password_change.sh",
    ]

    execute_command   = "echo 'rhel' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  ## Remove Red Hat subscriptions
  provisioner "shell" {
    scripts = [
      "${path.root}/../scripts/rhel/base/unsubscribe.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.redhat_unsubscribe || var.redhat_username == "" || var.redhat_password == "" ? ["parallels-iso.image"] : []
  }

  ## Package up the Vagrant box, if we're building one
  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = local.vagrant_output_dir
    vagrantfile_template = null
    except               = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }
}
