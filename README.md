# ZimaOS on Proxmox VM

There are two ways to install a [ZimaOS](https://github.com/IceWhaleTech/zimaos) VM on Proxmox: automatically and manually (partially automated).    
Automatic installation takes less than 2 minutes, while manual installation takes about 5 minutes.

* [Automatic](#automatic)
* [Manual](#manual-full-install)

## Automatic
Install ZimaOS in just 3 minutes. Simply run the command below on your Proxmox node, answer the VM creation prompts, and let the script handle the rest!

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/R0GGER/proxmox-zimaos/refs/heads/main/zimaos_zimacube.sh)"
```

https://github.com/user-attachments/assets/5502b6ae-d213-4fc8-a7a5-677225c59b6e

## Manual (full install)

### 1. Create a new VM in Proxmox:
* OS - Do not use any media
* System - BIOS - OMVF (UEFI) and choose a EFI storage (e.g., local-lvm)
* Next next next next (Disks, CPU, Memory, Network)
* Confirm - Finish (do not thick Start after created)
* Execute the script below in your Proxmox node (not in the VM!):
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/R0GGER/proxmox-zimaos/refs/heads/main/zimaos_zimacube_installer.sh)"
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

[https://www.youtube.com/watch?v=3n739Dia8eMz](https://www.youtube.com/watch?v=3n739Dia8eMz)    
Please note: The video has been fast-forwarded in some parts. 

----

### Add more drives (storage)
Go into Proxmox to your ZimaOS VM    
Hardware > Add > Harddisk    
Bus/Device: SATA   
![add-drive](https://github.com/user-attachments/assets/a3c2463f-6cc1-4671-9ddb-a717a06284e8)    

Inspired by bigbeartechworld - https://www.youtube.com/watch?v=o2H5pwLxOwA
