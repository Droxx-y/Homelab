# Homelab
Repository that holds all of my configration files for my homelab (Terraform, Ansible, Docker)

# Prerequisites

1.) Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installation-guide) and [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform#linux) on your system (if you are using a Windows machine consider using a Linux VM or WSL)

2.) Create an API token in Proxmox (Terraform needs this to authenticate to your server)

2.1) To create an API token go to your Proxmox server WebUI:

Select your datacenter > Permissions > API Tokens > Add > add a new API token to a specific user (you can use root) > enter a name for a token ID (for example terraform) > deselect "Priviledge Separation" > Add > copy the "Secret" token (be aware - if you close the window without first copying, you need to do the same process again because you cant see the secret later on anymore)

3.)

# Getting started

1.) Enter the "Terraform" directory and run the following commands:

```bash
# See what changes are about to be made, check for any issues/mistakes
terraform plan

# Apply the planned configuration
terraform apply
```

2.)
