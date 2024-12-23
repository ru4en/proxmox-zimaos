# ZimaOS on Proxmox VM

Create a new VM in Proxmox:
1. OS - Do not use any media
2. System - BIOS - OMVF (UEFI) and choose a EFI storage (e.g., local-lvm)
3. Disks - Next
4. CPU - Next
5. Memory - Next
6. Network - Next
7. Confirm - Finish (do not thick Start after created)

```
curl scriptname
```

### Answer the questions:
* Enter the URL of the custom image (.img):    
```
https://casaos.oss-cn-shanghai.aliyuncs.com/IceWhaleTech/zimaos-rauc/latest/zimaos_zimacube.img.xz
```
* Enter VM ID:
* Enter storage volume (e.g., local-lvm):


Inspired by https://www.youtube.com/watch?v=o2H5pwLxOwA
