# ZimaOS on Proxmox VM

### 1. Create a new VM in Proxmox:
* OS - Do not use any media
* System - BIOS - OMVF (UEFI) and choose a EFI storage (e.g., local-lvm)
* Disks - next
* CPU - next
* Memory - next
* Network - next
* Confirm - Finish (do not thick Start after created)
* Execute the script below in your Proxmox node (not in the VM!):
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/R0GGER/proxmox-zimaos/refs/heads/main/zimaos.sh)"
```

### 2. Answer the questions:
* Enter VM ID:
* Enter storage volume (e.g., local-lvm):

### 3. Go to created VM
Go to **Console** 
    
To ensure successful booting, you have to disable Secure Boot within the VM.   
Click **Start Now** and press **ESC** **ESC** **ESC** (multiple times) to load the virtual BIOS.    
Go to 'Secure Boot Configuration' option in 'Device Manager' and **disable 'Secure Boot'**.    
    
-> _Device Manager > Secure Boot Configuration > Attempt Secure Boot > Enter > Esc > Esc > Continue > Enter_

### 4. Install
Select **'1. Install ZimaOS'** and complete the installation wizard.   
Once the installation is complete, stop the VM by clicking **Stop** in Proxmox (not Shutdown). Disable **scsi1** and enable the correct disk **scsi0**.

### Video
*video...*

Inspired by https://www.youtube.com/watch?v=o2H5pwLxOwA
