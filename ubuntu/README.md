# Ubuntu base Machines with Packer and Vagrant

## Getting Started

This is a automated packer build for Ubuntu. It can create a Vagrant box or just a virtual machine in Parallels Desktop.
There are several parameters that can be set in the `variables.pkrvars.hcl` file. these will be explained in the next section.

## Prerequisites

To use these Packer scripts, you'll need to have the following software installed on your machine:

* [Packer](https://www.packer.io/)
* [Parallels Desktop](https://www.parallels.com/products/desktop/)
* [Parallels Virtualization SDK](https://www.parallels.com/products/desktop/download/)
* [Vagrant](https://www.vagrantup.com/) (optional)

### Parallels Virtualization SDK

The Parallels Virtualization SDK is required to build the virtual machine. It can be downloaded from the [Parallels website](https://www.parallels.com/products/desktop/download/). to use it in the packer you will need to add the path to the SDK to the `PYTHONPATH` environment variable. This can be done by adding the following line to your `.zhrc` file:

  ```bash
  export PYTHONPATH=$PYTHONPATH:/Library/Frameworks/ParallelsVirtualizationSDK.framework/Versions/Current/Libraries/Python/3.7
  ```

## Usage

To use a Packer script, first we need to set the variables in the `variables.pkrvars.hcl` file. You can either use the `variables_TEMPLATE.pkrvars.hcl` file as a template or copy it to `variables.pkrvars.hcl` and edit it.
This is the list of variables that can be set:

```hcl
version="23.04"
machine_name="ubuntu_23.04_LTS"
hostname="ubuntu-23.04"
machine_specs = {
  cpus = 2,
  memory = 2048,
  disk_size = "65536",
}
addons=[
  "desktop"
]
create_vagrant_box = false
```

### variables

* `version` - The version of Ubuntu to build. This can be any version that is available for ARM in the [Ubuntu release page](https://https://releases.ubuntu.com).
* `machine_name` - The name of the virtual machine in Parallels Desktop.
* `hostname` - The hostname of the virtual machine.
* `machine_specs` - The specs of the virtual machine. This is a map with the following keys:
  * `cpus` - The number of CPUs to assign to the virtual machine.
  * `memory` - The amount of memory to assign to the virtual machine.
  * `disk_size` - The size of the virtual disk in MB.
* `addons` - A list of addons to install. The following addons are available:
  * `desktop` - Installs the Ubuntu desktop.
  * `vscode` - Installs Visual Studio code.
* `create_vagrant_box` - If set to `true` a Vagrant box will be created. If set to `false` only a virtual machine will be created.

### Packer

### Validate build configuration

To validate the build configuration, navigate to the directory containing the script and run the following command:

```bash
$ packer validate -var-file variables.pkrvars.hcl .
```

You should see the following output:

```bash
$ The configuration is valid.
```

### Build Machine

To build the virtual machine, navigate to the directory containing the script and run the following command:

```bash
$ packer build .
```

This will create a new virtual machine based on the configuration in the Packer script in the out folder. if you set the `create_vagrant_box` variable to `true` a Vagrant box will be created in the `out` folder.

> **Note:** The build process can take a while depending on the speed of your machine and your internet connection.  

> The machine will not be automatically attached to Parallels Desktop. You will need to do this manually.