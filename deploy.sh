#!/bin/bash

cd terraform

terraform apply -auto-approve

sleep 180

cd ..

cd ansible

ansible-playbook -i inventory/hosts.ini playbook.yml --ssh-common-args='-o StrictHostKeyChecking=no'