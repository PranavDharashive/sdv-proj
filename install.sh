#!/bin/bash

LOG_FILE="install-$(date +%Y%m%d-%H%M%S).log"

# Prompt for Kube-apiserver endpoint IP
read -p "Enter the private IP address for Kube-apiserver endpoint: " KUBE_API_IP

# Prompt for Kubernetes version
read -p "Enter the Kubernetes version to install (e.g., 1.31.0): " K8S_VERSION

# Set KUBECONFIG environment variable for Ansible
export KUBECONFIG="$HOME/.kube/config"

export ANSIBLE_COLLECTIONS_PATHS=~/.ansible/collections

# Run the ansible playbook and log the output
ansible-playbook -i inventory.ini ansible/install.yml -e "kube_api_ip=$KUBE_API_IP" -e "k8s_version=$K8S_VERSION" | tee $LOG_FILE

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