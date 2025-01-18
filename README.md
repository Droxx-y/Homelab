> [!NOTE]  
> Still a work in progress!

# Homelab
Repository that holds all of my configration files for my homelab (Terraform, Ansible, Docker)

The main point of this project is to make the deployment automatic incase I ever need to recover my homelab from scratch or want to deploy it on someone elses server

# Prerequisites

1.) Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installation-guide) and [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform#linux) on your system (if you are using a Windows machine consider using a Linux VM or WSL)

2.) Create an API token in Proxmox (Terraform needs this to authenticate to your server)

*2.1) To create an API token go to your Proxmox server WebUI:

1. Select your datacenter

2. Go to Permissions

3. Select API Tokens > Add

4. Add a new API token to a specific user (you can use root)

5. Enter a name for a token ID (for example terraform) 

6. Deselect "Priviledge Separation" > Add

7. Copy the "Secret" token (be aware - if you close the window without first copying, you need to do the same process again because you cant see the secret later on anymore)

3.) Go to the "terraform folder", remove "_example" from credentials.auto.tfvars > change the values inside the file (URL, ID, Secret)

*3.1) While in the terraform folder - make sure you run `terraform init` to initialize the project

4.) After that go to the "proxmox directory", copy the bash script to your proxmox server and run it to create an Ubuntu server template that Terraform will later use to create a VM

*4.1) Theres no need to change settings of the VM at this point because Terraform will change them anyway - if you want to make changes to the VM, go to the "terraform" directory and change the values in "main.tf"

Once all the above steps are done, you can continue to the next step to start creating your homelab

# Getting started

1.) Run the `deploy.sh` script in the root of the project and wait for everything to be configured automatically (this will take approximately 10 minutes)

Once everything has been configured, you will recieve a message at the bottom telling you the IP addresses of all the services that were deployed in Portainer (the IP-s can be later found in a text file called "services.txt" in the root of local repository)
