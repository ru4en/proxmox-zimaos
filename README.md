# ZimaOS on Proxmox VM

Install ZimaOS in just 3 minutes. Simply run the command below on your Proxmox node, answer the VM creation prompts, and let the script handle the rest!

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/R0GGER/proxmox-zimaos/refs/heads/main/zimaos_zimacube.sh)"
```

### Add more drives (storage)
1. Shutdown your ZimaOS VM
2. Hardware > Add > Harddisk    
3. Bus/Device: SATA
4. Disk size: 100G
5. Start your ZimaOS VM
![add-drive](https://github.com/user-attachments/assets/a3c2463f-6cc1-4671-9ddb-a717a06284e8)

Inspired by bigbeartechworld - https://www.youtube.com/watch?v=o2H5pwLxOwA
