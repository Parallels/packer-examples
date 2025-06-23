# Variables Guide

This guide provides detailed explanations of the variables that can be set in the `variables.pkrvars.hcl` file for the macOS Virtual Machine Builder.

## User Variables

* `version` - Specifies the version of macOS to install. This will setup the correct boot commands, the available versions are:
  * `monterey`
  * `ventura`
  * `sonoma`
  * `sequoia` - Will always choose latest version of sequoia.
  * `sequoia_15.x` - Mention a specific version in sequoia. Installation steps were different for each version in sequoia, e.g., sequoia_15.1, sequoia_15.2 ... sequoia_15.5.

* `user` - This variable defines the user account to be created on the virtual machine. It contains two keys:
  * `username` - Specifies the username for the user.
  * `password` - Specifies the password for the user.

## Machine Settings

* `output_directory` - Specifies the directory where the virtual machine files will be saved.
* `machine_name` - Defines the name of the virtual machine in Parallels Desktop.
* `machine_specs` - This variable holds the hardware specifications for the virtual machine:  
  > **Note:** This will only be taken into consideration if you are building a macvm and not an ipsw.
  * `cpus` - Sets the number of CPUs to assign to the virtual machine.
  * `memory` - Sets the amount of memory (in MB) to assign to the virtual machine.

## Boot Settings

* `boot_command` - Determines the boot command used when starting the virtual machine. This is a string, and we've provided a default value compatible with macOS 13. However, you can specify your own or look at available options in the [boot commands](./boot_commands/index.md) directory.
* `boot_wait` - Determines the duration the script should wait for the virtual machine to boot. While 6 minutes is suitable for most machines, slower systems might require an extended wait time.

## macOS Source

* `macvm_path` - Specifies the path to the macvm virtual machine. If this is set, the script will use this virtual machine instead of downloading the IPSW.
* `ipsw_url` - Specifies the URL to the IPSW file to download. If this is set, the script will download the IPSW from this URL. You can also use a local IPSW by providing the full path to the IPSW file.
* `ipsw_checksum` - Specifies the checksum of the IPSW file. If this is set, the script will validate the checksum of the IPSW file after downloading it.

## Additional Options

* `addons` - Lists the addons to install on the virtual machine. The available addons include:
  * `vscode` - Installs Visual Studio Code.
* `create_vagrant_box` - If set to `true`, a Vagrant box will be created in addition to the virtual machine. If set to `false`, only a virtual machine will be created.
* `install_homebrew` - If set to `true`, install the Homebrew Package Manager for macOS.

Please remember to validate your configuration before running the Packer script to ensure all variables are set correctly.
