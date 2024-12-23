#!/bin/bash

# github.com/R0GGER/proxmox-zimaos
# bash -c "$(wget -qLO - https://raw.githubusercontent.com/R0GGER/proxmox-zimaos/refs/heads/main/zimaos.sh)"

echo -e "\nGET STARTED! Create a new VM:\n
 1. OS - Do not use any media
 2. System - BIOS - OMVF (UEFI) and choose a EFI storage (e.g. local-lvm)
 3. Disks - Next
 4. CPU - Next
 5. Memory - Next
 6. Network - Next
 7. Confirm - Finish (do not thick Start after created)\n"

read -p "Enter the URL of the custom image (.img): " URL
read -p "Enter VM ID: " VMID
read -p "Enter storage volume (e.g., local-lvm): " VOLUME

# Install dependencies
apt update
apt install -y xz-utils

# Variables
IMAGE=$(basename "$URL")
IMAGE_PATH="/var/lib/vz/images/$IMAGE"
DNR="2"
DISK="scsi1"

# Download the image
echo "Downloading the image..."
wget -O "$IMAGE_PATH" "$URL"
if [ $? -ne 0 ]; then
  echo "Error: Failed to download the image."
  exit 1
fi

# Extract image
echo "Extract the image..."
xz -d $IMAGE_PATH
if [ $? -ne 0 ]; then
  echo "Error: Failed to extract the image."
  exit 1
fi

# Import the disk
echo "Importing the disk..."
qm importdisk $VMID "$IMAGE_PATH" $VOLUME
if [ $? -ne 0 ]; then
  echo "Error: Failed to import the disk."
  exit 1
fi

# Attach the disk to the VM
echo "Attaching the disk..."
qm set $VMID --$DISK $VOLUME:vm-$VMID-disk-$DNR --boot c --scsihw virtio-scsi-pci -boot order=$DISK
if [ $? -ne 0 ]; then
  echo "Error: Failed to set the disk."
  exit 1
fi

echo "$IMAGE (.img) successfully added to $VMID."
