# Parallels Packer Templates

Welcome to our repository containing a collection of Packer scripts intended for creating diverse virtual machine configurations for the Parallels Desktop provider. 

## Quick Start

To begin, simply clone this repository onto your local machine with the following command:

```bash
git clone https://github.com/Parallels/parallels-packer-examples.git
```

## Pre-Installation

The following software is required to execute these Packer scripts:

* [Packer](https://www.packer.io/)
* [Parallels Desktop](https://www.parallels.com/products/desktop/)
* [Parallels Virtualization SDK](https://www.parallels.com/products/desktop/download/)
* [Vagrant](https://www.vagrantup.com/) (optional)

### Parallels Virtualization SDK

To utilize the Packer scripts, Parallels Virtualization SDK must be installed. The SDK can be downloaded from the [Parallels website](https://www.parallels.com/products/desktop/download/). To implement it with Packer, append the SDK path to the `PYTHONPATH` environment variable. This is achieved by adding the following line to your `.zhrc` file:

```bash
export PYTHONPATH=$PYTHONPATH:/Library/Frameworks/ParallelsVirtualizationSDK.framework/Versions/Current/Libraries/Python/3.7
```

## Repository Structure

Here is a brief overview of the repository's structure:

```bash
.
├── README.md
├── http
├── scripts
│   ├── macos
│   │   └── addons
│   ├── ubuntu
│   │   └── addons
│   └── windows
│       └── addons
├── macos
├── ubuntu
└── windows
```

* `http` - This directory holds files served by the web server during the VM installation process.
* `scripts` - This directory contains scripts executed during the VM installation.
  * `macos`, `ubuntu`, `windows` - These directories hold Packer scripts for the respective operating systems.
    * `addons` - This directory comprises scripts for installing additional features.
* `macos`, `ubuntu`, `windows` - These directories contain Packer scripts for their respective operating systems.

## Instructions

Each operating system has its own dedicated directory. For detailed instructions on how to use the scripts for each OS, refer to the README files provided:

* [macOS](macos/README.md)
* [Ubuntu](ubuntu/README.md)
* [Windows 11](windows/README.md)

## Collaboration

If you're interested in contributing to this repository, please create a fork and establish a new branch for your modifications. Upon finalizing your changes, submit a pull request for review. Join our [Discord](https://discord.gg/reuhvMFT) server to share ideas or request assistance.

## Customization Scripts and Add-ons

We offer a variety of scripts and add-ons housed in the `scripts` directory. These can be used to customize your virtual machine, including enhancements to existing add-ons created by our community or those unique to Parallels. Feel free to use them as necessary, and consider contributing your own by submitting a pull request.

## Licensing

This repository is licensed under the [MIT License](LICENSE).
