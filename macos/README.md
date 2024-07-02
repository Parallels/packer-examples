# Automated macOS Virtual Machine Builder with Packer and Vagrant for Apple Silicon Macs & Parallels Desktop

Create virtual macOS machines or Vagrant boxes in an automated, customizable fashion using Packer. This tool is designed specifically for Macs with Apple Silicon chip and leverages Parallels Desktop.

## Overview

This project provides automated Packer scripts to build macOS virtual machines or Vagrant boxes. It offers the flexibility to utilize either an IPSW file from the internet or a pre-built macvm virtual machine. The selected source can be defined by setting the `macvm_path` variable in the `variables.pkrvars.hcl` file. By default, the script will use and auto-download the IPSW for macOS 13.4.1 if no source is specified in the `variables.pkrvars.hcl` file.

## Prerequisites

Before running the scripts, ensure you have the following software installed on your machine:

* [Packer](https://www.packer.io/)
* [Parallels Desktop](https://www.parallels.com/products/desktop/)
* [Vagrant](https://www.vagrantup.com/) (optional)

Should you wish to use an IPSW other than the default (macOS 13.4.1), you'll need to download it manually and specify the `ipsw_url` and `ipsw_checksum` variables in the `variables.pkrvars.hcl` file. You can locate the IPSW files at [IPSW me](https://ipsw.me/).

### Calculating IPSW Checksum

If you opt for an alternate IPSW, you'll need to determine and define its checksum. Use the following command to calculate the checksum:

```bash
shasum -a 256 <path_to_ipsw>
```

You can then specify the resulting checksum in the `variables.pkrvars.hcl` file as follows:

```hcl
ipsw_checksum: "sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

## Usage

Prior to utilizing the Packer script, you must first establish the required variables in the `variables.pkrvars.hcl` file. You can use the `variables_TEMPLATE.pkrvars.hcl` file as a template or duplicate it to `variables.local.pkrvars.hcl` and modify it accordingly. Some of these variables have default values and don't need to be set explicitly.

You can set the following variables:

```hcl
user = {
  username = "parallels"
  password = "parallels"
}
output_directory = "out"
machine_name = "macOs-ventura-13.4.1"
machine_specs = {
  cpus   = 4,
  memory = 8192,
}
boot_command = ""
boot_wait = "6m"
macvm_path = ""
ipsw_url = ""
ipsw_checksum = ""
addons = [
]
create_vagrant_box = false
```

Refer to the detailed [variables guide](./VARIABLES.md) for information on each variable.

## New! Power of OCR in macOS automation

In [packer-plugin-parallels v1.2.0](https://github.com/Parallels/packer-plugin-parallels/releases/tag/v1.2.0), we introduced an OCR / Image recognition based boot scripts support for macOS VMs. To use this, define screens and corresponding actions like :

```hcl
boot_screen_config { # This configuration represents single screen.
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"] # boot command to execute when this screen is detected.
    screen_name      = "Language" # Give a name to identify in the logs.
    matching_strings = ["English", "Language", "Australia", "India"] # If system detects all of these texts in current screen, the corresponding boot_command will be executed.
  }

# Next screen - the configuration can go on!
boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Country"
    matching_strings = ["Select Your Country or Region"]
    is_last_screen   = true # Stops boot when boot_command of this screen executed.
  }

# If none of the screens are matching, execute an "empty" config :
boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "Empty"
    matching_strings = []
  }
```

This feature allows to execute complex installation / configuration procedures faster and accurate in macOS VMs. Refer to our examples provided for more details. We've covered installation procedures for macOS 12, 13 and 14. This includes navigating through the initial steps, enabling remote login, enabling passwordless sudo for provisioning and installing Parallels tools.

### Packer Commands

### Initialize Plugins

To initialize the Packer plugins, navigate to the directory containing the script and run the following command:

```bash
packer init .
```

#### Validate Build Configuration

Validate the build configuration with the following command in the directory containing the script:

```bash
packer validate -var-file variables.local.pkrvars.hcl .
```

A successful validation will yield the output:

```bash
The configuration is valid.
```

#### Build Machine

To initiate the build of the virtual machine, execute the following command in the directory with the script:

```bash
packer build -var-file variables.local.pkrvars.hcl .
```

This action will generate a new virtual machine as per the settings in the Packer script, placing it in the `out` directory. If the `create_vagrant_box` variable is set to `true`, a Vagrant box will also be generated in the `out` folder.

> **Note:** The build process duration depends on your machine's capabilities and internet connection speed.
> Post-build, the machine will not auto-attach to Parallels Desktop. This has to be performed manually.
