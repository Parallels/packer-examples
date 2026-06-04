# Automated Azure-Linux
 
Virtual Machine Builder with Packer for Apple Silicon Macs
 
Create virtual azure linux machines in an automated, customizable fashion using Packer. This tool is designed  specifically for Macs with Apple Sillicon chip and leverages Parallels Desktop.
 
## Overview
This project provides automated Packer scripts to build Azure-Linux virtual machines. It offers the flexibility to use any of the available ISO's for the distro. The selected source can be defined by setting the 'iso_url' variable in the 'variables.TEMPLATE.pkrvars.hcl' file. By default, the script will use and auto-download the ISO for Microsoft Azure-Linux 3.0 optimized for ARM64 architecture if no source is specified in the 'variables.pkrvars.hcl' file.
 
## Prerequisites
 
To use these Packer scripts, you'll need to have the following software installed on your machine:
 
* [Packer](https://www.packer.io/)
* [Parallels Desktop](https://www.parallels.com/products/desktop/)
* azure-linux ARM64 ISO link: "https://aka.ms/azurelinux-3.0-aarch64.iso"
 
 
### Calculating ISO Checksum
If you opt for an alternate ISO, you'll need to determine and define its checksum:
 
'''bash
 
shasum -a 256 <path_to_iso>
 
You can then specify the resulting checksum in the 'variables.TEMPLATE.pkrvars.hcl' file as follows:
'''hcl
iso_checksum:
"sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
'''
 
 
## Usage
Prior to utilizing the Packer script, you must first establish the required variables in the `variables.pkr.hcl` file. You can use the `variables_TEMPLATE.pkrvars.hcl` file as a template. Some of these variables have default values and don't need to be set explicitly.
 
You can set the following variables:
 
```hcl
vm_name="azure-linux3.0"

cpu_count = 2
memory_size = 3004
disk_size = 20480

iso_url = "https://aka.ms/azurelinux-3.0-aarch64.iso"
iso_checksum = "ff5970025e68f4d98b6c4779e03b455229ce5b554a10b235a2f11cb4a32339c2"
vm_username=""
vm_password=""               
# please replace blank with your own password (Make sure it passes the dictionary check and does not contain only sequential characters)
 
 
### Packer Commands
 
### Initialize Plugins
 
To initialize the Packer plugins, navigate to the directory containing the script and run the following command:
 
```bash
packer init .
```
 
#### Validate Build Configuration
 
Validate the build configuration with the following command in the directory containing the script:
 
```bash
packer validate -var-file="variables.TEMPLATE.pkrvars.hcl" .
```
 
A successful validation will yield the output:
 
```bash
The configuration is valid.
```
 
#### Build Machine
 
To initiate the build of the virtual machine, execute the following command in the directory with the script:
 
```bash
packer build -var-file="variables.TEMPLATE.pkrvars.hcl" .
```
 
This action will generate a new virtual machine as per the settings in the Packer script, placing it in the `out` directory.
 
> **Note:** The build process duration depends on your machine's capabilities and internet connection speed.  