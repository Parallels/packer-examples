# Variables Guide

This guide provides detailed explanations of the variables that can be set in the `variables.pkrvars.hcl` file for the CentOS Virtual Machine Builder.

## User Variables

* `user` - This variable defines the user account to be created on the virtual machine. It contains three keys:
  * `username` - Specifies the username for the user. Default is `parallels`.
  * `encrypted_password` - Specifies the encrypted password for the user in crypt format.
  * `password` - Specifies the plaintext password for the user. Default is `parallels`.

## Machine Settings

* `output_directory` - Specifies the directory where the virtual machine files will be saved. Default is `out`.
* `output_vagrant_directory` - Specifies the directory where the vagrant box will be saved. Default is `box/` directory in the project root.
* `machine_name` - Defines the name of the virtual machine in Parallels Desktop. If empty, defaults to `centos Server <version>`.
* `hostname` - Sets the hostname for the virtual machine. If empty, defaults to `centos-<version>` format.
* `machine_specs` - This variable holds the hardware specifications for the virtual machine:  
  > **Note:** This will only be taken into consideration if you are building a macvm and not an ipsw.
  * `cpus` - Sets the number of CPUs to assign to the virtual machine. Default is `2`.
  * `memory` - Sets the amount of memory (in MB) to assign to the virtual machine. Default is `2048`.
  * `disk_size` - Sets the size of the virtual disk (in MB) to assign to the virtual machine. Default is `65536`.

## Boot Settings

* `boot_command` - Determines the boot command used when starting the virtual machine. A default value is provided for CentOS. You can specify your own if needed.
* `boot_wait` - Determines the duration the script should wait for the virtual machine to boot. Default is `10s`.

## CentOS OS Source

* `iso_url` - Specifies the path to the CentOS ISO file or the URL for it to be downloaded. This is a required variable.
* `iso_checksum` - Specifies the checksum of the ISO file. This is a required variable. If set, the script will validate the checksum of the ISO file after downloading it.
* `version` - Specifies the version of CentOS being installed. Default is `2023.3`.

## Additional Options

* `install_desktop` - If set to `true`, installs a graphical desktop environment. If set to `false`, installs a server environment. Default is `true`.
* `shutdown_timeout` - Specifies the timeout (in seconds) to wait for the virtual machine to shutdown. If the virtual machine does not shutdown within this time, the script will exit with an error. Default is `15m`.
* `ssh_username` - Specifies the username to use when connecting to the virtual machine via SSH. If empty, defaults to the `user.username` value.
* `ssh_password` - Specifies the password to use when connecting to the virtual machine via SSH. If empty, defaults to the `user.password` value.
* `ssh_port` - Specifies the port to use when connecting to the virtual machine via SSH. Default is `22`.
* `ssh_wait_timeout` - Specifies the timeout (in seconds) to wait for the virtual machine to start SSH. If the virtual machine does not start SSH within this time, the script will exit with an error. Default is `10000s`.
* `ssh_timeout` - Specifies the timeout (in seconds) to wait for the virtual machine to respond to SSH. If the virtual machine does not respond to SSH within this time, the script will exit with an error. Default is `60m`.
* `addons` - Lists the addons to install on the virtual machine. The available addons include:
  * `ansible` - Installs Ansible Core.
  * `docker` - Installs Docker.
  * `git` - Installs Git.
  * `golang` - Installs Go.
  * `mariadb` - Installs MariaDB.
  * `podman` - Installs Red Hat Podman.
  * `python` - Installs Python3.
  * `vscode` - Installs Visual Studio Code.
* `create_vagrant_box` - If set to `true`, a Vagrant box will be created in addition to the virtual machine. If set to `false`, only a virtual machine will be created. Default is `false`.

Please remember to validate your configuration before running the Packer script to ensure all variables are set correctly.