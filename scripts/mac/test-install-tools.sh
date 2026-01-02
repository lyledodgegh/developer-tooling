#!/bin/bash

# Developer Tools Test Script for macOS
# This script verifies that installed development tools are working correctly

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters for results
PASSED=0
FAILED=0
TOTAL=0

# Helper function to print test results
test_command() {
    local cmd=$1
    local name=$2
    TOTAL=$((TOTAL + 1))
    
    echo -n "Testing $name... "
    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✓ PASS${NC}"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}✗ FAIL (not found)${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

test_brew_package() {
    local package=$1
    local name=$2
    TOTAL=$((TOTAL + 1))
    
    echo -n "Testing $name... "
    if brew list "$package" &> /dev/null; then
        echo -e "${GREEN}✓ PASS${NC}"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}✗ FAIL (not installed)${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

test_pip_package() {
    local package=$1
    local name=$2
    TOTAL=$((TOTAL + 1))
    
    echo -n "Testing $name... "
    if pip3 show "$package" &> /dev/null; then
        echo -e "${GREEN}✓ PASS${NC}"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}✗ FAIL (not installed)${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

test_npm_package() {
    local package=$1
    local name=$2
    TOTAL=$((TOTAL + 1))
    
    echo -n "Testing $name... "
    if npm list -g --depth=0 2>/dev/null | grep -q "$package"; then
        echo -e "${GREEN}✓ PASS${NC}"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}✗ FAIL (not installed)${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# Print header
echo "=========================================="
echo "  Developer Tools Test Suite for macOS"
echo "=========================================="
echo ""

# Test core tools
echo "Core Development Tools:"
echo "----------------------"
test_command brew "Homebrew"
test_command git "Git"
test_command node "Node.js"
test_command npm "npm"
test_command python3 "Python 3"
test_command pip3 "pip3"
echo ""

# Test editors and IDEs
echo "Editors and IDEs:"
echo "----------------"
if [ -d "/Applications/Visual Studio Code.app" ]; then
    echo -e "Testing Visual Studio Code... ${GREEN}✓ PASS${NC}"
    PASSED=$((PASSED + 1))
    TOTAL=$((TOTAL + 1))
else
    echo -e "Testing Visual Studio Code... ${RED}✗ FAIL${NC}"
    FAILED=$((FAILED + 1))
    TOTAL=$((TOTAL + 1))
fi
echo ""

# Test containerization
echo "Containerization Tools:"
echo "----------------------"
if [ -d "/Applications/Docker.app" ]; then
    echo -e "Testing Docker Desktop... ${GREEN}✓ PASS${NC}"
    PASSED=$((PASSED + 1))
    TOTAL=$((TOTAL + 1))
else
    echo -e "Testing Docker Desktop... ${RED}✗ FAIL${NC}"
    FAILED=$((FAILED + 1))
    TOTAL=$((TOTAL + 1))
fi
test_command docker "Docker CLI"
echo ""

# Test databases
echo "Databases:"
echo "---------"
test_brew_package postgresql@15 "PostgreSQL"
test_brew_package mysql "MySQL"
test_brew_package mongodb-community "MongoDB"
test_brew_package redis "Redis"
echo ""

# Test Kubernetes tools
echo "Kubernetes Tools:"
echo "----------------"
test_command kubectl "kubectl"
test_command helm "Helm"
test_command k9s "k9s"
test_command kubectx "kubectx"
test_command kubens "kubens"
echo ""

# Test infrastructure tools
echo "Infrastructure Tools:"
echo "--------------------"
test_command terraform "Terraform"
test_command aws "AWS CLI"
test_command az "Azure CLI"
test_command gcloud "Google Cloud SDK"
echo ""

# Test frontend tools
echo "Frontend Development Tools:"
echo "--------------------------"
test_command yarn "Yarn"
test_command tsc "TypeScript"
test_command create-react-app "Create React App"
test_command vue "Vue CLI"
test_command ng "Angular CLI"
echo ""

# Test AI/ML tools
echo "AI/ML Tools:"
echo "-----------"
test_command jupyter "Jupyter Notebook"
test_command pipenv "Pipenv"
test_pip_package tensorflow "TensorFlow"
test_pip_package torch "PyTorch"
test_pip_package sklearn "scikit-learn"
test_pip_package pandas "pandas"
test_pip_package numpy "numpy"
echo ""

# Test data engineering tools
echo "Data Engineering Tools:"
echo "----------------------"
test_brew_package apache-spark "Apache Spark"
test_command spark-submit "Spark Submit"
test_brew_package kafka "Apache Kafka"
echo ""

# Print summary
echo "=========================================="
echo "  Test Summary"
echo "=========================================="
echo -e "Total Tests: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed! ✓${NC}"
    exit 0
else
    echo -e "${YELLOW}Some tests failed. Please review the output above.${NC}"
    exit 1
fi
