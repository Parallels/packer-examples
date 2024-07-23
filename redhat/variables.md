# Variables Guide

This guide provides detailed explanations of the variables that can be set in the `variables.pkrvars.hcl` file for the Redhat Virtual Machine Builder.

## User Variables

* `user` - This variable defines the user account to be created on the virtual machine. It contains two keys:
  * `username` - Specifies the username for the user.
  * `encrypted_password` - Specifies the encrypted password for the user, this needs to be on a specific format for it to work.
  * `password` - Specifies the password for the user.

## Machine Settings

* `output_directory` - Specifies the directory where the virtual machine files will be saved.
* `output_vagrant_directory` - Specifies the directory where the vagrant box will be saved.
* `machine_name` - Defines the name of the virtual machine in Parallels Desktop.
* `machine_specs` - This variable holds the hardware specifications for the virtual machine:  
  > **Note:** This will only be taken into consideration if you are building a macvm and not an ipsw.
  * `cpus` - Sets the number of CPUs to assign to the virtual machine.
  * `memory` - Sets the amount of memory (in MB) to assign to the virtual machine.
  * `disk_size` - Sets the size of the virtual disk (in MB) to assign to the virtual machine.

## Boot Settings

* `boot_command` - Determines the boot command used when starting the virtual machine. This is a string, and we've provided a default value compatible with Kali Linux. However, you can specify your own or look at available options in the [boot commands](./boot_commands/index.md) directory.
* `boot_wait` - Determines the duration the script should wait for the virtual machine to boot. While 6 minutes is suitable for most machines, slower systems might require an extended wait time.

## Redhat OS Source

* `iso_url` - Specifies the path to the Kali Linux ISO file or the url for it to be downloaded.
* `iso_checksum` - Specifies the checksum of the ISO file. If this is set, the script will validate the checksum of the ISO file after downloading it.
* `redhat_username` - Specifies the username to use when registering your product.
* `redhat_password` - Specifies the password to use when registering your product.

## Additional Options

* `desktop` - Specifies the desktop flavor, you can choose between ```xfce```, ```gnome```, ```budgie``` or ```none```.
* `shutdown_timeout` - Specifies the timeout (in seconds) to wait for the virtual machine to shutdown. If the virtual machine does not shutdown within this time, the script will exit with an error.
* `ssh_username` - Specifies the username to use when connecting to the virtual machine via SSH.
* `ssh_password` - Specifies the password to use when connecting to the virtual machine via SSH.
* `ssh_port` - Specifies the port to use when connecting to the virtual machine via SSH.
* `ssh_wait_timeout` - Specifies the timeout (in seconds) to wait for the virtual machine to start SSH. If the virtual machine does not start SSH within this time, the script will exit with an error.
* `ssh_timeout` - Specifies the timeout (in seconds) to wait for the virtual machine to respond to SSH. If the virtual machine does not respond to SSH within this time, the script will exit with an error.
* `addons` - Lists the addons to install on the virtual machine. The available addons include:
  * `ansible` - Installs Ansible Core.`
  * `docker` - Installs Docker.
  * `git` - Installs Git.
  * `golang` - Installs Go.
  * `mariadb` - Installs MariaDB.
  * `podman` - Installs Redhat Podman.
  * `python` - Installs Python3.
  * `vscode` - Installs Visual Studio Code.
* `create_vagrant_box` - If set to `true`, a Vagrant box will be created in addition to the virtual machine. If set to `false`, only a virtual machine will be created.

Please remember to validate your configuration before running the Packer script to ensure all variables are set correctly.
