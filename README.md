# Aconfmgr Configuration

This repository contains my configuration files for using with the [aconfmgr](https://github.com/CyberShadow/aconfmgr) tool, which automates the management of an Arch Linux system's configuration.

Below is an overview of the structure, usage, and key customization aspects of this repository.

## Repository Structure

<!-- TODO: add repository structure and overview -->

## Usage

Make sure you have `aconfmgr` installed. Follow the steps in the [official documentation](https://github.com/CyberShadow/aconfmgr/blob/master/README.md) if you're new to the tool.

### Clone this repository

```bash
git clone https://github.com/Davi-S/aconfmgr-config.git ~/.config/aconfmgr
cd ~/.config/aconfmgr
```

### Inspect Changes

To preview changes without applying them:

```bash
aconfmgr diff
```

### Apply Configurations

To apply the configurations from this repo to the system:

```bash
aconfmgr apply
```

This will synchronize the system with the configurations defined in the repository.

## Contributing

If you have suggestions or improvements, feel free to open an issue or submit a pull request. This repository is a work-in-progress and evolves with my system.

## License

This repository is licensed under the [MIT License](LICENSE).
