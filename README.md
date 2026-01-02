# Developer Tooling

Automated scripts for setting up and maintaining common development tools, programming SDKs, frameworks, and infrastructure tooling on macOS and WSL (Windows Subsystem for Linux).

## Overview

This repository provides bash scripts that help developers quickly set up their development environment with the tools they need. Whether you're a full-stack developer, backend Kubernetes engineer, frontend specialist, AI/ML researcher, or data engineer, these scripts automate the installation and configuration of essential development tools.

## Features

- **Interactive Menu System**: Easy-to-use menu-driven interface
- **Multiple Developer Profiles**: Pre-configured tool sets for different types of developers
- **Package Manager Integration**: Uses Homebrew (macOS) and APT (WSL/Linux) for reliable installations
- **Progress Tracking**: Clear feedback on installation progress and errors
- **Update Capability**: Keep all your tools up-to-date with a single command
- **Testing Scripts**: Verify that tools are installed and working correctly

## Quick Start

### macOS

```bash
# Clone the repository
git clone https://github.com/lyledodgegh/developer-tooling.git
cd developer-tooling

# Make the script executable
chmod +x scripts/mac/install-tools.sh

# Run the installation script
./scripts/mac/install-tools.sh
```

### WSL/Linux

```bash
# Clone the repository
git clone https://github.com/lyledodgegh/developer-tooling.git
cd developer-tooling

# Make the script executable
chmod +x scripts/wsl/install-tools.sh

# Run the installation script
./scripts/wsl/install-tools.sh
```

## Developer Profiles

### 1. Full Stack Developer
Installs tools for full-stack web development:
- Git, Node.js, Python
- Docker
- PostgreSQL, Redis
- Visual Studio Code
- Yarn

### 2. Backend Kubernetes Developer
Installs tools for backend and container orchestration:
- Docker
- kubectl, Helm, k9s, kubectx/kubens
- Terraform
- AWS CLI, Azure CLI, Google Cloud SDK

### 3. Frontend Developer
Installs tools for frontend development:
- Node.js, npm, Yarn
- TypeScript
- React, Vue, and Angular CLIs
- Visual Studio Code

### 4. AI/ML Developer
Installs tools for artificial intelligence and machine learning:
- Python 3.x
- Jupyter Notebook
- TensorFlow, PyTorch
- scikit-learn, pandas, numpy
- Pipenv

### 5. Data Engineering
Installs tools for data processing and analytics:
- Python
- Apache Spark
- PostgreSQL, MySQL, MongoDB, Redis
- Apache Kafka
- pandas, numpy

### 6. Install All Tools
Installs all available development tools across all categories.

### 7. Update All Tools
Updates all installed tools to their latest stable versions.

## Testing Your Installation

After installing tools, verify they're working correctly:

### macOS
```bash
chmod +x scripts/mac/test-install-tools.sh
./scripts/mac/test-install-tools.sh
```

### WSL/Linux
```bash
chmod +x scripts/wsl/test-install-tools.sh
./scripts/wsl/test-install-tools.sh
```

## Documentation

For more detailed information, see the [documentation](doc/README.md).

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](doc/CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the terms of the LICENSE file in the root directory.

## Support

If you encounter issues or have questions:
1. Check the [documentation](doc/README.md)
2. Run the test script to identify specific problems
3. Open an issue on GitHub with details about your environment and the error

## Roadmap

- [ ] Add Windows native support (PowerShell scripts)
- [ ] Add support for more Linux distributions
- [ ] Add configuration management for installed tools
- [ ] Add uninstall functionality
- [ ] Add custom tool selection interface
