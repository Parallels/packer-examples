build {
  sources = ["source.parallels-iso.image"]

  ## 1. Miscellaneous setup items (No Red Hat check needed)
  provisioner "shell" {
    scripts = [
      "${path.root}/../scripts/ol/base/tmpdir.sh",
      "${path.root}/../scripts/ol/base/sshd.sh",
    ]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = false
  }

  ## 2. Update all OS Packages 
  ## Removed the Red Hat credential 'except' clause
  provisioner "shell" {
    scripts = [
      "${path.root}/../scripts/ol/base/update.sh",
    ]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  ## 3. Install Parallels Tools
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/ol/base/parallels.sh",
      "${path.root}/../scripts/ol/base/parallels_folders.sh",
    ]
    execute_command = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    pause_before    = "30s"
  }

  ## 4. Miscellaneous OS Cleanup
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
      "HOSTNAME=${local.hostname}",
    ]
    scripts = [
      "${path.root}/../scripts/ol/base/cleanup.sh",
      "${path.root}/../scripts/ol/base/change-hostname.sh",
    ]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  ## 5. Install a Graphical Desktop (Conditional on var.install_desktop only)
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "DEFAULT_USERNAME=${local.username}",
      "HOSTNAME=${local.hostname}",
    ]
    scripts = [
      "${path.root}/../scripts/ol/base/desktop.sh",
    ]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.install_desktop ? ["parallels-iso.image"] : []
  }

  ## 6. Vagrant SSH Key
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]
    scripts           = ["${path.root}/../scripts/ol/base/vagrant_ssh_key.sh"]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  ## 7. Addons (Simplified logic)
  provisioner "file" {
    source      = "${path.root}/../scripts/ol/addons"
    destination = "/parallels-tools"
    direction   = "upload"
    # Only skip if no addons are defined
    except = length(var.addons) == 0 ? ["parallels-iso.image"] : []
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
      "ADDONS=${local.addons}",
      "ADDONS_DIR=/parallels-tools/addons"
    ]
    scripts           = ["${path.root}/../scripts/ol/addons/install.sh"]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
    expect_disconnect = true
    timeout           = "3h"
    except            = length(var.addons) == 0 ? ["parallels-iso.image"] : []
  }

  ## 8. Post-Processor
  post-processor "vagrant" {
    compression_level   = 9
    keep_input_artifact = false
    output              = local.vagrant_output_dir
    except              = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }
}