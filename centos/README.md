# Automated CentOS Virtual Machine Builder with Packer and Vagrant for Apple Silicon Macs & Parallels Desktop

Create virtual CentOS machines or Vagrant boxes in an automated, customizable fashion using Packer. This tool is designed specifically for Macs with Apple Silicon chip and leverages Parallels Desktop.

## Overview

This project provides automated Packer scripts to build CentOS virtual machines or Vagrant boxes. It offers the flexibility to use any of the available ISO's for the distro. The selected source can be defined by setting the `iso_url` variable in the `variables.pkrvars.hcl` file. By default, the script will use and auto-download the ISO for CentOS 2023.3 if no source is specified in the `variables.pkrvars.hcl` file.

CentOS is available freely from [here](https://www.centos.org/).

## Prerequisites

To use these Packer scripts, you'll need to have the following software installed on your machine:

* [Packer](https://www.packer.io/)
* [Parallels Desktop](https://www.parallels.com/products/desktop/)
* [Vagrant](https://www.vagrantup.com/) (optional)
* CentOS ISO

### Calculating ISO Checksum

If you opt for an alternate ISO, you'll need to determine and define its checksum. Use the following command to calculate the checksum:

```bash
shasum -a 256 <path_to_iso>
```

You can then specify the resulting checksum in the `variables.pkrvars.hcl` file as follows:

```hcl
iso_checksum: "sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

## Usage

Prior to utilizing the Packer script, you must first establish the required variables in the `variables.pkrvars.hcl` file. You can use the `variables_TEMPLATE.pkrvars.hcl` file as a template or duplicate it to `variables.local.pkrvars.hcl` and modify it accordingly. Some of these variables have default values and don't need to be set explicitly.

You can set the following variables:

```hcl
version="2023.3"
machine_name="CentOS Server"
hostname="centos-2023-3"
machine_specs = {
  cpus = 2,
  memory = 2048,
  disk_size = "65536",
}
addons=[]
install_desktop=true
iso_url = ""
iso_checksum = ""
create_vagrant_box = false
```

Refer to the detailed [variables guide](./variables.md) for information on each variable.

### Packer Commands

#### Initialize Plugins

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