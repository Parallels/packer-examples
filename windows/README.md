# Windows 11 on ARM base Machines with Packer and Vagrant for Parallels Desktop and Mac with Apple Silicon chip

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

### Windows 11 on ARM ISO

You will need to download the Windows 11 on ARM ISO.
Microsoft only provides the VHDXok file. You can get one by using the [UUP Dump](https://uupdump.net/) service. 

* Select the latest Windows 11 build for ARM64
* follow the online instructions to download the scripts
* run the `uup_download_macos.sh` script
  > This will require some extra software to be installed on your Mac. Follow the instructions in the ```readme.unix.md``` file that is created in the directory where you run the script.

  * Alternatively you can use a linux VM and run the `uup_download_linux.sh` script from there, you will still need to install all of the required software, but it is a bit easier to do on linux and you will have a cleaner environment.
* Once the script has finished you will have an usable ISO file in the script directory. you can either copy it into this folder or you can use that folder as the isoPath.
* you will also need to get the file checksum in sha-256, you can get this by running the following command:

 ```bash
  shasum -a 256 <path to iso>
  ```

## Autounattend.xml and the Windows Answer File

The Windows Answer File is used to automate the installation of Windows. It is a XML file that is used by Windows Setup to configure the installation. It can be used to automate the installation of Windows, but it can also be used to configure the Windows installation. This is done by adding the configuration to the `autounattend.xml` file. This file is then used by Windows Setup to configure the installation.

We have a ready to use `unattended.iso` that contains this plus all the required bits to install Windows 11 on ARM. If you want to further customize this for example the default user, you can use the `autounattend.xml` file in this repository in `scripts/windows/answer_files` as a starting point and add your own configuration to it. You will need to generate a new `unattended.iso` file. This can be done by running the following command:

```bash
hdiutil makehybrid -iso -joliet -o unattended.iso ./answer_files
```

once this is done replace the current `unattended.iso` file with the new one.

## Usage

To use a Packer script, first we need to set the variables in the `variables.pkrvars.hcl` file. You can either use the `variables_TEMPLATE.pkrvars.hcl` file as a template or copy it to `variables.override.pkrvars.hcl` and edit it.
This is the list of variables that can be set:

```hcl
iso_url=""
iso_checksum="" 
machine_specs = {
  cpus = 2,
  memory = 2048,
  disk_size = "65536",
}
addons = [] 
create_vagrant_box = false
```

### variables

* `iso_url` - Path to the Windows 11 on ARM ISO file.
* `iso_checksum` - The generated iso checksum in this format "sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", check readme in how to generate
* `machine_specs` - The specs of the virtual machine. This is a map with the following keys:
  * `cpus` - The number of CPUs to assign to the virtual machine.
  * `memory` - The amount of memory to assign to the virtual machine.
  * `disk_size` - The size of the virtual disk in MB.
* `addons` - A list of addons to install. The following addons are available:
  * `developers` - Install some of the most common developer tools.
  * `docker-desktop` - Install Docker.
  * `dotnet-framework-6-sdk` - Install the .NET Framework 6 SDK.
  * `dotnet-framework-7-sdk` - Install the .NET Framework 7 SDK.
  * `flutter` - Install Flutter.
  * `git` - Install Git.
  * `golang` - Install Go.
  * `podman` - Install Redhat Podman.
  * `vcredist-2022` - Install the Visual C++ Redistributable for Visual Studio 2022.
  * `vscode` - Install Visual Studio Code.
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

## Addons Scripts

We have two flavors of addons scripts, one using chocolatey and one using winget. The chocolatey scripts are in the `scripts/windows/addons/choco` folder and the winget scripts are in the `scripts/windows/addons/winget` folder. The chocolatey scripts are the ones that are used to install the addons during the creation of the machine. If you want to use the winget scripts you will need to install them after the machine is ready.
This is because we use ssh to install the addons during the creation of the machine and the ssh is runned in the system context, and at the moment that is not allowed by winget.

## Vagrant box

### Default users

If you are planning to use the Vagrant box, you cannot change the default user from Vagrant, this is because Vagrant uses the `vagrant` user to connect to the machine. If you change the default user, Vagrant will not be able to connect to the machine and the setup will fail. You can however add more users to the machine changing the `autounattend.xml` file.

### Vagrantfile

To create a machine from the vagrant box we need a Vagrantfile. Doing a `vagrant init <box name>` will not work because we need to do some adjustements to the Vagrantfile. You can use this template and copy it to a new folder and call it `Vagrantfile`:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "<box name>"
  config.vm.communicator = "winssh"
  config.vm.guest = :windows
end
```

  where `<box name>` is the name of the box that you created.

## Known Issues

* The Windows 11 on ARM ISO is not available for download from Microsoft. You will need to get it from a third party.
* We use the Microsoft OpenSSH to connect to the machine and configure it, this process might fail due to Microsoft OpenSSH not being able to connect to the machine. If the process starts to take more than 15 minutes check if the machine is running any script, if not then use `ctrl+c` to stop the process and try again.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.