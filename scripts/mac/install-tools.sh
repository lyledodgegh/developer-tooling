#!/bin/bash

# Developer Tools Installation Script for macOS
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

# Check if Homebrew is installed
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        print_info "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        if command -v brew &> /dev/null; then
            print_success "Homebrew installed successfully"
        else
            print_error "Failed to install Homebrew"
            exit 1
        fi
    else
        print_success "Homebrew is already installed"
    fi
}

# Individual Tool Installation Functions

install_git() {
    print_info "Installing Git..."
    if brew install git; then
        print_success "Git installed successfully"
        return 0
    else
        print_error "Failed to install Git"
        return 1
    fi
}

install_nodejs() {
    print_info "Installing Node.js..."
    if brew install node; then
        print_success "Node.js installed successfully"
        return 0
    else
        print_error "Failed to install Node.js"
        return 1
    fi
}

install_python() {
    print_info "Installing Python 3..."
    if brew install python@3.11; then
        print_success "Python 3 installed successfully"
        return 0
    else
        print_error "Failed to install Python 3"
        return 1
    fi
}

install_docker() {
    print_info "Installing Docker..."
    if brew install --cask docker; then
        print_success "Docker installed successfully"
        print_warning "Please launch Docker Desktop to complete setup"
        return 0
    else
        print_error "Failed to install Docker"
        return 1
    fi
}

install_vscode() {
    print_info "Installing Visual Studio Code..."
    if brew install --cask visual-studio-code; then
        print_success "Visual Studio Code installed successfully"
        return 0
    else
        print_error "Failed to install Visual Studio Code"
        return 1
    fi
}

install_postgresql() {
    print_info "Installing PostgreSQL..."
    if brew install postgresql@15; then
        print_success "PostgreSQL installed successfully"
        print_info "To start PostgreSQL: brew services start postgresql@15"
        return 0
    else
        print_error "Failed to install PostgreSQL"
        return 1
    fi
}

install_redis() {
    print_info "Installing Redis..."
    if brew install redis; then
        print_success "Redis installed successfully"
        print_info "To start Redis: brew services start redis"
        return 0
    else
        print_error "Failed to install Redis"
        return 1
    fi
}

install_mysql() {
    print_info "Installing MySQL..."
    if brew install mysql; then
        print_success "MySQL installed successfully"
        print_info "To start MySQL: brew services start mysql"
        return 0
    else
        print_error "Failed to install MySQL"
        return 1
    fi
}

install_mongodb() {
    print_info "Installing MongoDB..."
    if brew tap mongodb/brew && brew install mongodb-community; then
        print_success "MongoDB installed successfully"
        print_info "To start MongoDB: brew services start mongodb-community"
        return 0
    else
        print_error "Failed to install MongoDB"
        return 1
    fi
}

install_kubectl() {
    print_info "Installing kubectl..."
    if brew install kubectl; then
        print_success "kubectl installed successfully"
        return 0
    else
        print_error "Failed to install kubectl"
        return 1
    fi
}

install_helm() {
    print_info "Installing Helm..."
    if brew install helm; then
        print_success "Helm installed successfully"
        return 0
    else
        print_error "Failed to install Helm"
        return 1
    fi
}

install_k9s() {
    print_info "Installing k9s..."
    if brew install k9s; then
        print_success "k9s installed successfully"
        return 0
    else
        print_error "Failed to install k9s"
        return 1
    fi
}

install_kubectx() {
    print_info "Installing kubectx and kubens..."
    if brew install kubectx; then
        print_success "kubectx and kubens installed successfully"
        return 0
    else
        print_error "Failed to install kubectx"
        return 1
    fi
}

install_terraform() {
    print_info "Installing Terraform..."
    if brew tap hashicorp/tap && brew install hashicorp/tap/terraform; then
        print_success "Terraform installed successfully"
        return 0
    else
        print_error "Failed to install Terraform"
        return 1
    fi
}

install_awscli() {
    print_info "Installing AWS CLI..."
    if brew install awscli; then
        print_success "AWS CLI installed successfully"
        return 0
    else
        print_error "Failed to install AWS CLI"
        return 1
    fi
}

install_azure_cli() {
    print_info "Installing Azure CLI..."
    if brew install azure-cli; then
        print_success "Azure CLI installed successfully"
        return 0
    else
        print_error "Failed to install Azure CLI"
        return 1
    fi
}

install_gcloud() {
    print_info "Installing Google Cloud SDK..."
    if brew install --cask google-cloud-sdk; then
        print_success "Google Cloud SDK installed successfully"
        return 0
    else
        print_error "Failed to install Google Cloud SDK"
        return 1
    fi
}

install_yarn() {
    print_info "Installing Yarn..."
    if brew install yarn; then
        print_success "Yarn installed successfully"
        return 0
    else
        print_error "Failed to install Yarn"
        return 1
    fi
}

install_typescript() {
    print_info "Installing TypeScript globally..."
    if npm install -g typescript; then
        print_success "TypeScript installed successfully"
        return 0
    else
        print_error "Failed to install TypeScript"
        return 1
    fi
}

install_react_cli() {
    print_info "Installing Create React App..."
    if npm install -g create-react-app; then
        print_success "Create React App installed successfully"
        return 0
    else
        print_error "Failed to install Create React App"
        return 1
    fi
}

install_vue_cli() {
    print_info "Installing Vue CLI..."
    if npm install -g @vue/cli; then
        print_success "Vue CLI installed successfully"
        return 0
    else
        print_error "Failed to install Vue CLI"
        return 1
    fi
}

install_angular_cli() {
    print_info "Installing Angular CLI..."
    if npm install -g @angular/cli; then
        print_success "Angular CLI installed successfully"
        return 0
    else
        print_error "Failed to install Angular CLI"
        return 1
    fi
}

install_jupyter() {
    print_info "Installing Jupyter Notebook..."
    if pip3 install jupyter; then
        print_success "Jupyter Notebook installed successfully"
        return 0
    else
        print_error "Failed to install Jupyter Notebook"
        return 1
    fi
}

install_pipenv() {
    print_info "Installing Pipenv..."
    if pip3 install pipenv; then
        print_success "Pipenv installed successfully"
        return 0
    else
        print_error "Failed to install Pipenv"
        return 1
    fi
}

install_tensorflow() {
    print_info "Installing TensorFlow..."
    if pip3 install tensorflow; then
        print_success "TensorFlow installed successfully"
        return 0
    else
        print_error "Failed to install TensorFlow"
        return 1
    fi
}

install_pytorch() {
    print_info "Installing PyTorch..."
    if pip3 install torch torchvision torchaudio; then
        print_success "PyTorch installed successfully"
        return 0
    else
        print_error "Failed to install PyTorch"
        return 1
    fi
}

install_scikit_learn() {
    print_info "Installing scikit-learn..."
    if pip3 install scikit-learn; then
        print_success "scikit-learn installed successfully"
        return 0
    else
        print_error "Failed to install scikit-learn"
        return 1
    fi
}

install_pandas() {
    print_info "Installing pandas..."
    if pip3 install pandas; then
        print_success "pandas installed successfully"
        return 0
    else
        print_error "Failed to install pandas"
        return 1
    fi
}

install_numpy() {
    print_info "Installing numpy..."
    if pip3 install numpy; then
        print_success "numpy installed successfully"
        return 0
    else
        print_error "Failed to install numpy"
        return 1
    fi
}

install_apache_spark() {
    print_info "Installing Apache Spark..."
    if brew install apache-spark; then
        print_success "Apache Spark installed successfully"
        return 0
    else
        print_error "Failed to install Apache Spark"
        return 1
    fi
}

install_kafka() {
    print_info "Installing Apache Kafka..."
    if brew install kafka; then
        print_success "Apache Kafka installed successfully"
        print_info "To start Kafka: brew services start kafka"
        return 0
    else
        print_error "Failed to install Apache Kafka"
        return 1
    fi
}

# Category Installation Functions

install_fullstack_tools() {
    echo ""
    print_info "Installing Full Stack Development Tools..."
    echo "=============================================="
    
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
    
    print_info "Updating Homebrew..."
    brew update
    
    print_info "Upgrading all Homebrew packages..."
    brew upgrade
    
    print_info "Upgrading all Homebrew casks..."
    brew upgrade --cask --greedy
    
    print_info "Updating npm packages..."
    if command -v npm &> /dev/null; then
        npm update -g
    fi
    
    print_info "Updating pip packages..."
    if command -v pip3 &> /dev/null; then
        pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
    fi
    
    print_info "Cleaning up..."
    brew cleanup
    
    print_success "All tools updated successfully!"
}

# Display menu
show_menu() {
    clear
    echo "=================================================="
    echo "  Developer Tools Installation Script for macOS"
    echo "=================================================="
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
    # Check for Homebrew first
    check_homebrew
    
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
