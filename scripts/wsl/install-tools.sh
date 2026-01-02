#!/bin/bash

# Developer Tools Installation Script for WSL/Linux
# This script provides a menu-driven interface to install common development tools

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function to print colored messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Update package lists
update_apt() {
    print_info "Updating package lists..."
    if sudo apt-get update; then
        print_success "Package lists updated"
        return 0
    else
        print_error "Failed to update package lists"
        return 1
    fi
}

# Individual Tool Installation Functions

install_git() {
    print_info "Installing Git..."
    if sudo apt-get install -y git; then
        print_success "Git installed successfully"
        return 0
    else
        print_error "Failed to install Git"
        return 1
    fi
}

install_nodejs() {
    print_info "Installing Node.js..."
    # Install Node.js from NodeSource repository for latest LTS
    if ! command -v node &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    fi
    
    if sudo apt-get install -y nodejs; then
        print_success "Node.js installed successfully"
        return 0
    else
        print_error "Failed to install Node.js"
        return 1
    fi
}

install_python() {
    print_info "Installing Python 3..."
    if sudo apt-get install -y python3 python3-pip python3-venv; then
        print_success "Python 3 installed successfully"
        return 0
    else
        print_error "Failed to install Python 3"
        return 1
    fi
}

install_docker() {
    print_info "Installing Docker..."
    
    # Install prerequisites
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    
    # Add Docker's official GPG key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    # Set up the repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Update package lists
    sudo apt-get update
    
    if sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; then
        # Add current user to docker group
        sudo usermod -aG docker $USER
        print_success "Docker installed successfully"
        print_warning "Please log out and log back in for Docker group changes to take effect"
        return 0
    else
        print_error "Failed to install Docker"
        return 1
    fi
}

install_vscode() {
    print_info "Installing Visual Studio Code..."
    
    # Import Microsoft GPG key
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    
    # Add VS Code repository
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    
    rm -f packages.microsoft.gpg
    
    sudo apt-get update
    
    if sudo apt-get install -y code; then
        print_success "Visual Studio Code installed successfully"
        return 0
    else
        print_error "Failed to install Visual Studio Code"
        return 1
    fi
}

install_postgresql() {
    print_info "Installing PostgreSQL..."
    if sudo apt-get install -y postgresql postgresql-contrib; then
        print_success "PostgreSQL installed successfully"
        print_info "To start PostgreSQL: sudo service postgresql start"
        return 0
    else
        print_error "Failed to install PostgreSQL"
        return 1
    fi
}

install_redis() {
    print_info "Installing Redis..."
    if sudo apt-get install -y redis-server; then
        print_success "Redis installed successfully"
        print_info "To start Redis: sudo service redis-server start"
        return 0
    else
        print_error "Failed to install Redis"
        return 1
    fi
}

install_mysql() {
    print_info "Installing MySQL..."
    if sudo apt-get install -y mysql-server; then
        print_success "MySQL installed successfully"
        print_info "To start MySQL: sudo service mysql start"
        return 0
    else
        print_error "Failed to install MySQL"
        return 1
    fi
}

install_mongodb() {
    print_info "Installing MongoDB..."
    
    # Import MongoDB public GPG key
    curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
    
    # Create list file for MongoDB
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
    
    sudo apt-get update
    
    if sudo apt-get install -y mongodb-org; then
        print_success "MongoDB installed successfully"
        print_info "To start MongoDB: sudo systemctl start mongod"
        return 0
    else
        print_error "Failed to install MongoDB"
        return 1
    fi
}

install_kubectl() {
    print_info "Installing kubectl..."
    
    # Download the latest release
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    
    # Install kubectl
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    
    if command -v kubectl &> /dev/null; then
        print_success "kubectl installed successfully"
        return 0
    else
        print_error "Failed to install kubectl"
        return 1
    fi
}

install_helm() {
    print_info "Installing Helm..."
    
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    
    if command -v helm &> /dev/null; then
        print_success "Helm installed successfully"
        return 0
    else
        print_error "Failed to install Helm"
        return 1
    fi
}

install_k9s() {
    print_info "Installing k9s..."
    
    # Get latest version
    K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    
    wget "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz"
    tar -xzf k9s_Linux_amd64.tar.gz
    sudo install -o root -g root -m 0755 k9s /usr/local/bin/k9s
    rm k9s k9s_Linux_amd64.tar.gz
    
    if command -v k9s &> /dev/null; then
        print_success "k9s installed successfully"
        return 0
    else
        print_error "Failed to install k9s"
        return 1
    fi
}

install_kubectx() {
    print_info "Installing kubectx and kubens..."
    
    sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
    sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
    sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
    
    if command -v kubectx &> /dev/null && command -v kubens &> /dev/null; then
        print_success "kubectx and kubens installed successfully"
        return 0
    else
        print_error "Failed to install kubectx and kubens"
        return 1
    fi
}

install_terraform() {
    print_info "Installing Terraform..."
    
    # Add HashiCorp GPG key
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    
    # Add HashiCorp repository
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    sudo apt-get update
    
    if sudo apt-get install -y terraform; then
        print_success "Terraform installed successfully"
        return 0
    else
        print_error "Failed to install Terraform"
        return 1
    fi
}

install_awscli() {
    print_info "Installing AWS CLI..."
    
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    
    if command -v aws &> /dev/null; then
        print_success "AWS CLI installed successfully"
        return 0
    else
        print_error "Failed to install AWS CLI"
        return 1
    fi
}

install_azure_cli() {
    print_info "Installing Azure CLI..."
    
    # Get Microsoft signing key
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
    
    # Add Azure CLI repository
    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
    
    sudo apt-get update
    
    if sudo apt-get install -y azure-cli; then
        print_success "Azure CLI installed successfully"
        return 0
    else
        print_error "Failed to install Azure CLI"
        return 1
    fi
}

install_gcloud() {
    print_info "Installing Google Cloud SDK..."
    
    # Add Google Cloud SDK repository
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    
    # Import Google Cloud public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    
    sudo apt-get update
    
    if sudo apt-get install -y google-cloud-sdk; then
        print_success "Google Cloud SDK installed successfully"
        return 0
    else
        print_error "Failed to install Google Cloud SDK"
        return 1
    fi
}

install_yarn() {
    print_info "Installing Yarn..."
    
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    
    sudo apt-get update
    
    if sudo apt-get install -y yarn; then
        print_success "Yarn installed successfully"
        return 0
    else
        print_error "Failed to install Yarn"
        return 1
    fi
}

install_typescript() {
    print_info "Installing TypeScript globally..."
    if sudo npm install -g typescript; then
        print_success "TypeScript installed successfully"
        return 0
    else
        print_error "Failed to install TypeScript"
        return 1
    fi
}

install_react_cli() {
    print_info "Installing Create React App..."
    if sudo npm install -g create-react-app; then
        print_success "Create React App installed successfully"
        return 0
    else
        print_error "Failed to install Create React App"
        return 1
    fi
}

install_vue_cli() {
    print_info "Installing Vue CLI..."
    if sudo npm install -g @vue/cli; then
        print_success "Vue CLI installed successfully"
        return 0
    else
        print_error "Failed to install Vue CLI"
        return 1
    fi
}

install_angular_cli() {
    print_info "Installing Angular CLI..."
    if sudo npm install -g @angular/cli; then
        print_success "Angular CLI installed successfully"
        return 0
    else
        print_error "Failed to install Angular CLI"
        return 1
    fi
}

install_jupyter() {
    print_info "Installing Jupyter Notebook..."
    if pip3 install --user jupyter; then
        print_success "Jupyter Notebook installed successfully"
        print_warning "Add ~/.local/bin to PATH if not already done"
        return 0
    else
        print_error "Failed to install Jupyter Notebook"
        return 1
    fi
}

install_pipenv() {
    print_info "Installing Pipenv..."
    if pip3 install --user pipenv; then
        print_success "Pipenv installed successfully"
        return 0
    else
        print_error "Failed to install Pipenv"
        return 1
    fi
}

install_tensorflow() {
    print_info "Installing TensorFlow..."
    if pip3 install --user tensorflow; then
        print_success "TensorFlow installed successfully"
        return 0
    else
        print_error "Failed to install TensorFlow"
        return 1
    fi
}

install_pytorch() {
    print_info "Installing PyTorch..."
    if pip3 install --user torch torchvision torchaudio; then
        print_success "PyTorch installed successfully"
        return 0
    else
        print_error "Failed to install PyTorch"
        return 1
    fi
}

install_scikit_learn() {
    print_info "Installing scikit-learn..."
    if pip3 install --user scikit-learn; then
        print_success "scikit-learn installed successfully"
        return 0
    else
        print_error "Failed to install scikit-learn"
        return 1
    fi
}

install_pandas() {
    print_info "Installing pandas..."
    if pip3 install --user pandas; then
        print_success "pandas installed successfully"
        return 0
    else
        print_error "Failed to install pandas"
        return 1
    fi
}

install_numpy() {
    print_info "Installing numpy..."
    if pip3 install --user numpy; then
        print_success "numpy installed successfully"
        return 0
    else
        print_error "Failed to install numpy"
        return 1
    fi
}

install_apache_spark() {
    print_info "Installing Apache Spark..."
    
    # Install Java (required for Spark)
    sudo apt-get install -y openjdk-11-jdk
    
    # Download and install Spark
    # NOTE: Update these version numbers periodically to get the latest stable release
    # Check https://spark.apache.org/downloads.html for the latest version
    SPARK_VERSION="3.5.0"
    HADOOP_VERSION="3"
    wget "https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
    sudo tar -xzf "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" -C /opt/
    sudo mv "/opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" /opt/spark
    rm "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
    
    # Add to PATH in bashrc if not already there
    if ! grep -q "SPARK_HOME" ~/.bashrc; then
        echo 'export SPARK_HOME=/opt/spark' >> ~/.bashrc
        echo 'export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin' >> ~/.bashrc
    fi
    
    print_success "Apache Spark installed successfully"
    print_warning "Please restart your shell or run: source ~/.bashrc"
    return 0
}

install_kafka() {
    print_info "Installing Apache Kafka..."
    
    # Install Java (required for Kafka)
    sudo apt-get install -y openjdk-11-jdk
    
    # Download and install Kafka
    # NOTE: Update these version numbers periodically to get the latest stable release
    # Check https://kafka.apache.org/downloads for the latest version
    KAFKA_VERSION="3.6.1"
    SCALA_VERSION="2.13"
    wget "https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
    sudo tar -xzf "kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" -C /opt/
    sudo mv "/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}" /opt/kafka
    rm "kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
    
    # Add to PATH in bashrc if not already there
    if ! grep -q "KAFKA_HOME" ~/.bashrc; then
        echo 'export KAFKA_HOME=/opt/kafka' >> ~/.bashrc
        echo 'export PATH=$PATH:$KAFKA_HOME/bin' >> ~/.bashrc
    fi
    
    print_success "Apache Kafka installed successfully"
    print_warning "Please restart your shell or run: source ~/.bashrc"
    return 0
}

# Category Installation Functions

install_fullstack_tools() {
    echo ""
    print_info "Installing Full Stack Development Tools..."
    echo "=============================================="
    
    update_apt
    install_git
    install_nodejs
    install_python
    install_vscode
    install_docker
    install_postgresql
    install_redis
    install_yarn
    
    print_success "Full Stack tools installation complete!"
}

install_backend_kubernetes_tools() {
    echo ""
    print_info "Installing Backend Kubernetes Development Tools..."
    echo "=================================================="
    
    update_apt
    install_git
    install_docker
    install_kubectl
    install_helm
    install_k9s
    install_kubectx
    install_terraform
    install_awscli
    install_azure_cli
    install_gcloud
    
    print_success "Backend Kubernetes tools installation complete!"
}

install_frontend_tools() {
    echo ""
    print_info "Installing Frontend Development Tools..."
    echo "========================================"
    
    update_apt
    install_git
    install_nodejs
    install_yarn
    install_vscode
    install_typescript
    install_react_cli
    install_vue_cli
    install_angular_cli
    
    print_success "Frontend tools installation complete!"
}

install_aiml_tools() {
    echo ""
    print_info "Installing AI/ML Development Tools..."
    echo "====================================="
    
    update_apt
    install_git
    install_python
    install_vscode
    install_jupyter
    install_pipenv
    install_tensorflow
    install_pytorch
    install_scikit_learn
    install_pandas
    install_numpy
    
    print_success "AI/ML tools installation complete!"
}

install_data_engineering_tools() {
    echo ""
    print_info "Installing Data Engineering Tools..."
    echo "===================================="
    
    update_apt
    install_git
    install_python
    install_vscode
    install_apache_spark
    install_postgresql
    install_mysql
    install_mongodb
    install_redis
    install_kafka
    install_pandas
    install_numpy
    
    print_success "Data Engineering tools installation complete!"
}

install_all_tools() {
    echo ""
    print_info "Installing All Development Tools..."
    echo "==================================="
    
    update_apt
    
    # Core tools
    install_git
    install_nodejs
    install_python
    install_vscode
    install_docker
    
    # Databases
    install_postgresql
    install_mysql
    install_mongodb
    install_redis
    
    # Kubernetes tools
    install_kubectl
    install_helm
    install_k9s
    install_kubectx
    
    # Infrastructure tools
    install_terraform
    install_awscli
    install_azure_cli
    install_gcloud
    
    # Frontend tools
    install_yarn
    install_typescript
    
    # AI/ML tools
    install_jupyter
    install_pipenv
    install_pandas
    install_numpy
    
    # Data Engineering tools
    install_apache_spark
    install_kafka
    
    print_success "All tools installation complete!"
}

update_all_tools() {
    echo ""
    print_info "Updating All Installed Tools..."
    echo "==============================="
    
    print_info "Updating package lists..."
    sudo apt-get update
    
    print_info "Upgrading all APT packages..."
    sudo apt-get upgrade -y
    
    print_info "Updating npm packages..."
    if command -v npm &> /dev/null; then
        sudo npm update -g
    fi
    
    print_info "Updating pip packages..."
    if command -v pip3 &> /dev/null; then
        pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install --user -U || true
    fi
    
    print_info "Cleaning up..."
    sudo apt-get autoremove -y
    sudo apt-get autoclean
    
    print_success "All tools updated successfully!"
}

# Display menu
show_menu() {
    clear
    echo "======================================================"
    echo "  Developer Tools Installation Script for WSL/Linux"
    echo "======================================================"
    echo ""
    echo "Please select an option:"
    echo ""
    echo "  1) Install All Tools"
    echo "  2) Full Stack Developer Tools"
    echo "  3) Backend Kubernetes Developer Tools"
    echo "  4) Frontend Developer Tools"
    echo "  5) AI/ML Developer Tools"
    echo "  6) Data Engineering Tools"
    echo "  7) Update All Tools"
    echo "  8) Exit"
    echo ""
    echo -n "Enter your choice [1-8]: "
}

# Main execution
main() {
    # Check if running with sufficient privileges
    if [ "$EUID" -eq 0 ]; then 
        print_warning "Please do not run this script as root. It will use sudo when needed."
        exit 1
    fi
    
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1)
                install_all_tools
                echo ""
                read -p "Press Enter to continue..."
                ;;
            2)
                install_fullstack_tools
                echo ""
                read -p "Press Enter to continue..."
                ;;
            3)
                install_backend_kubernetes_tools
                echo ""
                read -p "Press Enter to continue..."
                ;;
            4)
                install_frontend_tools
                echo ""
                read -p "Press Enter to continue..."
                ;;
            5)
                install_aiml_tools
                echo ""
                read -p "Press Enter to continue..."
                ;;
            6)
                install_data_engineering_tools
                echo ""
                read -p "Press Enter to continue..."
                ;;
            7)
                update_all_tools
                echo ""
                read -p "Press Enter to continue..."
                ;;
            8)
                echo ""
                print_info "Exiting. Thank you for using the Developer Tools Installer!"
                exit 0
                ;;
            *)
                print_error "Invalid option. Please try again."
                sleep 2
                ;;
        esac
    done
}

# Run the main function
main
