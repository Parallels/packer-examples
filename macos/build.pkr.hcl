build {
  sources = local.sources

  # PARALLELS TOOLS INSTALLATION 
  provisioner "shell" {
    # Increase to 60s: macOS 26 needs extra time to mount the Tools ISO after login
    pause_before = "60s" 
    
    inline = [
      "echo 'Cleaning up restored sessions...'",
      # Force-closes any 'stuck' or 'restored' Terminal windows
      "sudo pkill -x 'Terminal' || true", 
      "sleep 5",
      "echo 'Starting silent Parallels Tools Installation via SSH...'",
      # Direct silent install command
      "sudo /Volumes/Parallels\\ Tools/Install.app/Contents/MacOS/PTIAgent --install",
      "echo 'Installation triggered. The .pvm will be generated after the final reboot.'"
    ]
    # Uses your local.ssh_password to authenticate the sudo commands
    execute_command = "echo '${local.ssh_password}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    # Expect a disconnect because the installer will trigger a system restart
    expect_disconnect = true 
  }
  
  ## Install the insecure Vagrant ssh key, if we're building a Vagrant box
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/Users/${local.username}",
      "USERNAME=${local.username}",
    ]

    scripts = [
      "${path.root}/../scripts/macos/base/vagrant_ssh_key.sh",
    ]

    execute_command   = "echo '${local.username}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    expect_disconnect = true
    except            = !var.create_vagrant_box ? local.vagrant_sources : []
  }

  ## Install the Homebrew Package Manager
  provisioner "shell" {
    environment_vars = [
      "NONINTERACTIVE=1"
    ]

    inline = [
      "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"",
      "(echo; echo 'eval \"$(/opt/homebrew/bin/brew shellenv)\"') >> /Users/${local.username}/.zprofile"
    ]

    timeout           = "30m"
    except            = !var.install_homebrew ? local.sources : []
  }

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
