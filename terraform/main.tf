resource "proxmox_vm_qemu" "portainer" {
  name                    = "portainer"
  vmid                    = 100
  target_node             = "proxmox"
  clone                   = "ubuntu-server"
  full_clone              = true
  cores                   = 1
  sockets                 = 1
  memory                  = 4096
  agent                   = 1
  scsihw                  = "virtio-scsi-pci"
  bootdisk                = "scsi0"
  os_type                 = "cloud-init"

  network {
    id = 0
    bridge = "vmbr0"
    model  = "virtio"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 100
        }
      }
    }
  }

  ipconfig0 = "ip=192.168.1.151/24,gw=192.168.1.1"
  sshkeys   = <<EOF
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmaJRA/c+abJPeYV28sKLpt3HStULMIX5EaLG+L1y7O sysadmin@DESKTOP-K7M5TMC
  EOF
}
