#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Catch errors in pipelines

echo "Starting Minikube setup for Kubernetes cluster..."

# Function to install Minikube
install_minikube() {
    echo "Checking if Minikube is installed..."
    if ! command -v minikube &> /dev/null; then
        echo "Minikube not found. Installing Minikube..."
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
        sudo dpkg -i minikube_latest_amd64.deb
        
        echo "Minikube installed successfully."
    else
        echo "Minikube is already installed."
    fi
}

# Function to install kubectl
install_kubectl() {
    echo "Checking if kubectl is installed..."
    if ! command -v kubectl &> /dev/null; then
        echo "kubectl not found. Installing kubectl..."
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
        curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
        sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring
        echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
        sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly
        sudo apt-get update
        sudo apt-get install -y kubectl
    else
        echo "kubectl is already installed."
    fi
}

# Start Minikube
start_minikube() {
    echo "Starting Minikube cluster..."
    minikube start
    echo "Minikube cluster started."
}

# Deploy the Flask app using the provided YAML file
deploy_flask_app() {
    echo "Deploying Flask app to the Minikube cluster..."
    if [ -f "deployment-service.yaml" ]; then
        kubectl apply -f deployment-service.yaml
        echo "Flask app deployed successfully."
    else
        echo "Error: deployment-service.yaml file not found in the current directory."
        exit 1
    fi
}

# Execution starts here
install_minikube
install_kubectl
start_minikube
deploy_flask_app

echo "Setup complete! Use 'kubectl get pods' to check the status of your deployment."
