# Parallels Packer Examples

This repository contains examples of Packer scripts that create different types of virtual machines for the Parallels Desktop provider.

## Getting Started

To get started, clone this repository to your local machine:

```bash
git clone https://github.com/Parallels/parallels-packer-examples.git
```

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

## Contributing

If you'd like to contribute to this repository, please fork the repository and create a new branch for your changes. Once you've made your changes, submit a pull request and we'll review your changes.

## License

This repository is licensed under the [MIT License](LICENSE).
