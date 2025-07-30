#!/bin/bash

LOG_FILE="install-$(date +%Y%m%d-%H%M%S).log"

# Prompt for Kube-apiserver endpoint IP
read -p "Enter the private IP address for Kube-apiserver endpoint: " KUBE_API_IP

# Set KUBECONFIG environment variable for Ansible
export KUBECONFIG="$HOME/.kube/config"

# Run the ansible playbook and log the output
ansible-playbook -i inventory.ini ansible/install.yml -e "kube_api_ip=$KUBE_API_IP" | tee $LOG_FILE
