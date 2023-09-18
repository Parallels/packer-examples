# Automated Redhat Virtual Machine Builder with Packer and Vagrant for Apple Silicon Macs & Parallels Desktop

Create virtual Redhat machines or Vagrant boxes in an automated, customizable fashion using Packer. This tool is designed specifically for Macs with Apple Silicon chip and leverages Parallels Desktop.

## Overview

This project provides automated Packer scripts to build Redhat virtual machines or Vagrant boxes. It offers the flexibility to use any of the available ISO's for the distro. The selected source can be defined by setting the `iso_url` variable in the `variables.pkrvars.hcl` file. By default, the script will use and auto-download the ISO for Redhat 2023.3 if no source is specified in the `variables.pkrvars.hcl` file.
Because Redhat is a commercial distro, you will need to provide your own iso, you can source a trial version from [here](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux).
You also will need to provide a Redhat username/password if you want to install any addons has this is required by redhat

## Prerequisites

To use these Packer scripts, you'll need to have the following software installed on your machine:

* [Packer](https://www.packer.io/)
* [Parallels Desktop](https://www.parallels.com/products/desktop/)
* [Parallels Virtualization SDK](https://www.parallels.com/products/desktop/download/) (if Parallels Desktop 18 or below)
* [Vagrant](https://www.vagrantup.com/) (optional)
* Redhat ISO

### Calculating ISO Checksum

If you opt for an alternate ISO, you'll need to determine and define its checksum. Use the following command to calculate the checksum:

```bash
shasum -a 256 <path_to_iso>
```

You can then specify the resulting checksum in the `variables.pkrvars.hcl` file as follows:

```hcl
iso_checksum: "sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### Setting up Parallels Virtualization SDK (Optional)

The Parallels Virtualization SDK is required to build the virtual machine if you are running **Parallels Desktop 18** or below, otherwise skip this strp. It can be downloaded from the [Parallels website](https://www.parallels.com/products/desktop/download/). to use it in the packer you will need to add the path to the SDK to the `PYTHONPATH` environment variable. This can be done by adding the following line to your `.zhrc` file:

  ```bash
  export PYTHONPATH=$PYTHONPATH:/Library/Frameworks/ParallelsVirtualizationSDK.framework/Versions/Current/Libraries/Python/3.7
  ```

## Usage

Prior to utilizing the Packer script, you must first establish the required variables in the `variables.pkrvars.hcl` file. You can use the `variables_TEMPLATE.pkrvars.hcl` file as a template or duplicate it to `variables.local.pkrvars.hcl` and modify it accordingly. Some of these variables have default values and don't need to be set explicitly.

You can set the following variables:

```hcl
version="9.2"
machine_name="Redhat Server"
hostname="redhat-9"
machine_specs = {
  cpus = 2,
  memory = 2048,
  disk_size = "65536",
}
addons=[
]
install_desktop=true
iso_url = ""
iso_checksum = ""
redhat_username=""
redhat_password=""
create_vagrant_box = false
```

Refer to the detailed [variables guide](./VARIABLES.md) for information on each variable.

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
