build {
  sources = [
    "source.parallels-iso.image"
  ]

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/debian/base/sudoers.sh",
      "${path.root}/../scripts/debian/base/update.sh",
      "${path.root}/../scripts/debian/base/sshd.sh",
      "${path.root}/../scripts/debian/base/networking.sh",
      "${path.root}/../scripts/debian/base/systemd.sh",
      "${path.root}/../scripts/debian/base/parallels.sh",
      "${path.root}/../scripts/debian/base/parallels_folders.sh",
    ]

    execute_command = "echo '${local.username}' | {{ .Vars }} sudo -S -E bash -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]

    scripts = [
      "${path.root}/../scripts/debian/base/vagrant.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? ["parallels-iso.image"] : []
  }

  provisioner "file" {
    source      = "${path.root}/../scripts/debian/addons"
    destination = "/tmp/addons_upload" 
    direction   = "upload"
    except      = length(var.addons) > 0 ? [] : ["parallels-iso.image"]
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
      "ADDONS=${join(",", var.addons)}",
      "ADDONS_DIR=/parallels-tools/addons"
    ]

    inline = [
      "sudo mkdir -p /parallels-tools/addons",
      "sudo mv /tmp/addons_upload/* /parallels-tools/addons/",
      "sudo chown -R ${local.username}:${local.username} /parallels-tools",
      "bash -eux /parallels-tools/addons/install.sh"
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
      "${path.root}/../scripts/debian/base/clean_user_snap_folder.sh",
    ]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S env USERNAME=${local.username} sh -eux '{{ .Path }}'"
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/${local.username}",
      "USERNAME=${local.username}",
    ]
    scripts = [
      "${path.root}/../scripts/debian/base/password_change.sh",
    ]
    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S env USERNAME=${local.username} sh -eux '{{ .Path }}'"
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
