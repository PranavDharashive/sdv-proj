#!/bin/bash

LOG_FILE="install-$(date +%Y%m%d-%H%M%S).log"
exec &> >(tee -a "$LOG_FILE")

# Prompt for Kube-apiserver endpoint IP
read -p "Enter the private IP address for Kube-apiserver endpoint: " KUBE_API_IP

# Prompt for Kubernetes version with validation
K8S_VERSION=""
while [[ ! "$K8S_VERSION" =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; do
  read -p "Enter the Kubernetes version to install (e.g., 1.31.0, 1.31): " K8S_VERSION
  if [[ ! "$K8S_VERSION" =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Invalid Kubernetes version format. Please enter a version like 1.31.0 or 1.31."
  fi
done

# Install Ansible if not already installed
if ! command -v ansible &> /dev/null
then
    echo "Ansible not found, installing..."
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
    echo "Ansible version installed is:"
    ansible --version
else
    echo "Ansible is already installed."
    ansible --version
fi

# Set KUBECONFIG environment variable for Ansible
export KUBECONFIG="$HOME/.kube/config"

export ANSIBLE_COLLECTIONS_PATHS=~/.ansible/collections

# Install required Ansible collections
ansible-galaxy collection install kubernetes.core
ansible-galaxy collection install community.general

# Run the ansible playbook and log the output
ansible-playbook -i inventory.ini ansible/install.yml -e "kube_api_ip=$KUBE_API_IP" -e "k8s_version=$K8S_VERSION"

# Check if the ansible-playbook command was successful
# if [ $? -eq 0 ]; then
#   echo "===================================================="
#   echo "All components deployed and running successfully:"
#   echo "===================================================="
#   echo "1. Kubernetes cluster (v1.31) is up and running."
#   echo "2. Monitoring stack (Prometheus & Grafana) is up and running."
#   echo "3. Redis service is up and running."
#   echo "4. MySQL service is up and running."
#   echo "5. MinIO service is up and running."
#   echo "6. SDV application is up and running."
#   echo "7. SDV Nginx/frontend application is up and running."
#   echo "===================================================="
# else
#   echo "\n===================================================="
#   echo "Installation failed. Please check the logs in $LOG_FILE for details."
#   echo "===================================================="
# fi
