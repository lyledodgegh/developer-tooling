# Developer Tooling Documentation

## Overview

This repository provides automated scripts to help developers set up common development tools, programming SDKs, frameworks, and infrastructure tooling on macOS and WSL (Windows Subsystem for Linux).

## Supported Platforms

- **macOS**: Uses Homebrew as the primary package manager
- **WSL/Linux**: Uses APT package manager

## Available Scripts

### Installation Scripts

- **macOS**: `/scripts/mac/install-tools.sh`
- **WSL/Linux**: `/scripts/wsl/install-tools.sh`

These scripts provide an interactive menu system to install tools based on your development needs.

### Test Scripts

- **macOS**: `/scripts/mac/test-install-tools.sh`
- **WSL/Linux**: `/scripts/wsl/test-install-tools.sh`

These scripts verify that installed tools are working correctly.

## Installation Options

The installation scripts offer the following options:

1. **Install All Tools**: Installs all available development tools
2. **Full Stack Developer**: Tools for full-stack web development (Node.js, Python, databases, etc.)
3. **Backend Kubernetes Developer**: Tools for backend and container orchestration (Docker, kubectl, Helm, etc.)
4. **Frontend Developer**: Tools for frontend development (Node.js, yarn, build tools, etc.)
5. **AI/ML Developer**: Tools for artificial intelligence and machine learning (Python, TensorFlow, PyTorch, etc.)
6. **Data Engineering**: Tools for data processing and analytics (Python, Spark, databases, etc.)
7. **Update All Tools**: Updates all installed tools to their latest stable versions

## Usage

### macOS

```bash
# Make the script executable
chmod +x scripts/mac/install-tools.sh

# Run the installation script
./scripts/mac/install-tools.sh

# Test the installations
chmod +x scripts/mac/test-install-tools.sh
./scripts/mac/test-install-tools.sh
```

### WSL/Linux

```bash
# Make the script executable
chmod +x scripts/wsl/install-tools.sh

# Run the installation script
./scripts/wsl/install-tools.sh

# Test the installations
chmod +x scripts/wsl/test-install-tools.sh
./scripts/wsl/test-install-tools.sh
```

## Tool Categories

### Full Stack Development
- Node.js and npm
- Python and pip
- Git
- Docker
- PostgreSQL
- Redis
- VS Code extensions support

### Backend Kubernetes Development
- Docker
- kubectl
- Helm
- k9s
- kubectx/kubens
- Terraform
- AWS CLI
- Azure CLI
- Google Cloud SDK

### Frontend Development
- Node.js and npm
- Yarn
- Webpack
- TypeScript
- React/Vue/Angular CLIs

### AI/ML Development
- Python 3.x
- pip and pipenv
- Jupyter Notebook
- TensorFlow
- PyTorch
- scikit-learn
- pandas, numpy

### Data Engineering
- Python
- Apache Spark
- PostgreSQL
- MySQL
- MongoDB
- Redis
- Kafka tools

## Prerequisites

### macOS
- macOS 10.14 or later
- Administrator access
- Internet connection

### WSL/Linux
- Ubuntu 20.04 or later (or compatible Debian-based distribution)
- Sudo privileges
- Internet connection

## Troubleshooting

If you encounter issues:

1. Ensure you have the necessary permissions (sudo/admin)
2. Check your internet connection
3. Review the error messages displayed during installation
4. Run the test script to identify which tools failed to install
5. Refer to the individual tool's documentation for specific installation issues

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## License

See the LICENSE file in the root directory for license information.
