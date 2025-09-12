#!/bin/bash

LOG_FILE="cleanup-$(date +%Y%m%d-%H%M%S).log"

# Run the ansible playbook and log the output
ansible-playbook -i inventory.ini ansible/cleanup.yml | tee $LOG_FILE
