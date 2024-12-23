# ZimaOS on Proxmox VM

### 1. Create a new VM in Proxmox:
* OS - Do not use any media
* System - BIOS - OMVF (UEFI) and choose a EFI storage (e.g., local-lvm)
* Disks - Next
* CPU - Next
* Memory - Next
* Network - Next
* Confirm - Finish (do not thick Start after created)
* Execute the script below in your Proxmox Node (not in the VM!):
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/R0GGER/proxmox-zimaos/refs/heads/main/zimaos.sh)"
```

### 2. Answer the questions:
* Enter the URL of the custom image (.img):    
```
https://casaos.oss-cn-shanghai.aliyuncs.com/IceWhaleTech/zimaos-rauc/latest/zimaos_zimacube_installer.img
```
* Enter VM ID:
* Enter storage volume (e.g., local-lvm):

### 3. Go to created VM
* Go to console
* To ensure successful booting, you have to disable Secure Boot within the VM.   
Click Start Now and press Escape (Esc) multiple times during start to load the virtual BIOS.    
Go to ‘Secure Boot Configuration’ option in ‘Device Manager,’ and disable Secure Boot.    

Device Manager > Secure Boot Configuration > Attempt Secure Boot > Enter > Esc > Esc > Continue > Enter

### Video
video

Inspired by https://www.youtube.com/watch?v=o2H5pwLxOwA
