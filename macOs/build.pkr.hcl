

build {
  sources = local.sources

  // provisioner "shell" {
  //   // environment_vars = [
  //   //   "HOME_DIR=/home/${local.username}",
  //   //   "USERNAME=${local.username}",
  //   // ]
  //   scripts = [
  //     "${path.root}/../scripts/ubuntu/base/sudoers.sh",
  //     "${path.root}/../scripts/ubuntu/base/parallels.sh",
  //   ]

  //   execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
  //   expect_disconnect = true
  // }

  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    output               = "${path.root}/box/${local.machine_name}.box"
    vagrantfile_template = null
    except               = !var.create_vagrant_box ? local.sources : []
  }
}