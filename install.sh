#!/bin/bash

LOG_FILE="install-$(date +%Y%m%d-%H%M%S).log"

# Run the ansible playbook and log the output
ansible-playbook -i inventory.ini ansible/install.yml | tee $LOG_FILE
