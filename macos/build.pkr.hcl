build {
  sources = local.sources

  provisioner "file" {
    source      = "${path.root}/../scripts/macos/addons"
    destination = "/Users/${local.username}/parallels-tools"
    direction   = "upload"
    except      = length(var.addons) > 0 ? [] : local.sources
  }

  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/Users/${local.username}",
      "USERNAME=${local.username}",
      "ADDONS=${local.addons}",
      "ADDONS_DIR=/Users/${local.username}/parallels-tools"
    ]

    scripts = [
      "${path.root}/../scripts/macos/addons/install.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} bash -eux '{{ .Path }}'"
    expect_disconnect = true
    timeout           = "3h"
    except            = length(var.addons) > 0 ? [] : local.sources
  }


  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = local.vagrant_output_dir
    vagrantfile_template = null
    except               = !var.create_vagrant_box ? local.vagrant_sources : []
  }
}