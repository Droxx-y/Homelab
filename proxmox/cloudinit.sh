#!/bin/bash

# Check if the Ubuntu server cloud image is available locally; if not, download it.
if [ ! -f "jammy-server-cloudimg-amd64.img" ]; then
    wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
fi 

# Create a new virtual machine (ID 8000) with the following specifications:
# - 4GB of RAM
# - Virtio network interface connected to vmbr0
# - Enable QEMU guest agent
qm create 8000 --name ubuntu-server --memory 4096 --net0 virtio,bridge=vmbr0 --agent 1

# Import the cloud image disk to the local storage (local-lvm)
qm importdisk 8000 jammy-server-cloudimg-amd64.img local-lvm

# Configure the virtual machine to use VirtIO SCSI for disk interface
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0

# Add a cloud-init configuration as an IDE device for initialization
qm set 8000 --ide2 local-lvm:cloudinit

# Set boot parameters to boot from the SCSI disk (disk 0)
qm set 8000 --boot c --bootdisk scsi0

# Configure serial console for management via a terminal
qm set 8000 --serial0 socket --vga serial0

# Configure the network interface to use DHCP for IP assignment
qm set 8000 --ipconfig0 ip=dhcp

# Resize the disk (scsi0) to 50GB
qm resize 8000 scsi0 100G

# Create a directory for cloud-init snippets (to customize cloud instance setup)
mkdir -p /var/lib/vz/snippets

# Move to the cloud-init snippets directory
cd /var/lib/vz/snippets

# Create the cloud-init configuration file (cloud-init.yaml) with specified options
cat <<EOF > cloud-init.yaml
#cloud-config
# Update packages and reboot if necessary
package_update: true
package_upgrade: true
package_reboot_if_required: true

# Install required packages, such as the QEMU guest agent
packages:
- qemu-guest-agent

# Ensure the QEMU guest agent service is started after the machine boots
runcmd:
- systemctl start qemu-guest-agent
EOF

# Set the cloud-init configuration for the virtual machine
qm set 8000 --cicustom "vendor=local:snippets/cloud-init.yaml"

# Set the default user for the instance (sysadmin)
qm set 8000 --ciuser sysadmin

# Set the default password for the user, ensuring it is securely hashed using SHA-512
qm set 8000 --cipassword $(openssl passwd -6 $CLEARTEXT_PASSWORD)

# Start the virtual machine
qm start 8000

# Sleep for 2 minutes to ensure the VM is fully initialized and can process the cloud-init configuration
sleep 120

# Stop the virtual machine once initialization is complete
qm stop 8000

# Sleep for 10 seconds to ensure the VM is properly stopped
sleep 10

# Convert the virtual machine into a template (ID 8000), making it reusable for future instances
qm template 8000
