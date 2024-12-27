#!/bin/bash

# Version
V="1.3.0-2"

# Variables
URL="https://github.com/IceWhaleTech/ZimaOS/releases/download/$V"
IMAGE="zimaos_zimacube-$V.img.xz"
EXTRACTED_IMAGE="zimaos_zimacube-$V.img"
IMAGE_PATH="/var/lib/vz/images/$IMAGE"
EXTRACTED_PATH="/var/lib/vz/images/$EXTRACTED_IMAGE"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Remove any old zimaos image files
echo "Cleaning up any existing image files..."
rm -f "/var/lib/vz/images/"zimaos_zimacube*.img "/var/lib/vz/images/"zimaos_zimacube*.img.xz

validate_number() {
    if ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "Error: Please enter a valid number"
        exit 1
    fi
}

check_vmid() {
    if qm status $1 >/dev/null 2>&1; then
        echo "Error: VMID $1 already exists"
        exit 1
    fi
}

clear

echo -e "${YELLOW}=== Proxmox ZimaOS VM Creator ===${NC}"
echo

# Get VMID
read -p "Enter VMID (100-999): " VMID
validate_number $VMID
check_vmid $VMID

# Get VM name
read -p "Enter VM name: " VM_NAME

# Get volume (default local-lvm)
read -p "Enter volume [local-lvm]: " VOLUME
VOLUME=${VOLUME:-local-lvm}

# Get memory size (default 2048)
read -p "Enter memory size in MB [2048]: " MEMORY
MEMORY=${MEMORY:-2048}
validate_number $MEMORY

# Get number of cores (default 2)
read -p "Enter number of CPU cores [2]: " CORES
CORES=${CORES:-2}
validate_number $CORES

echo -e "\n${GREEN}Creating VM with the following parameters:${NC}"
echo "VMID: $VMID"
echo "Name: $VM_NAME"
echo "Volume: $VOLUME"
echo "Memory: $MEMORY MB"
echo "Cores: $CORES"
echo "Image: $IMAGE"

read -p "Continue? (y/n): " CONFIRM
if [[ $CONFIRM != [yY] ]]; then
    echo "Operation cancelled"
    exit 0
fi

echo -e "\n${GREEN}Starting VM creation process...${NC}"

# Download the image
echo "Downloading the image..."
wget -q --show-progress -O "$IMAGE_PATH" "$URL/$IMAGE"
if [ $? -ne 0 ]; then
  echo "Error: Failed to download the image."
  exit 1
fi

# Extract the image
echo "Extracting the image..."
xz -df "$IMAGE_PATH"
if [ $? -ne 0 ]; then
  echo "Error: Failed to extract the image."
  rm -f "$IMAGE_PATH" # Cleanup if extraction fails
  exit 1
fi

# Verify extracted image exists
if [ ! -f "$EXTRACTED_PATH" ]; then
  echo "Error: Extracted image file not found at $EXTRACTED_PATH"
  exit 1
fi

# Create VM
echo "Creating VM..."
qm create $VMID --name $VM_NAME --memory $MEMORY --cores $CORES -localtime 1 -bios ovmf -ostype l26 --net0 virtio,bridge=vmbr0

# Create EFI disk
echo "Creating EFI disk..."
pvesm alloc $VOLUME $VMID vm-$VMID-disk-0 4M
qm set $VMID -efidisk0 $VOLUME:vm-$VMID-disk-0,efitype=4m
if [ $? -ne 0 ]; then
  echo "Error: Failed to create EFI disk."
  exit 1
fi

# Import the disk
echo "Importing the disk..."
qm importdisk $VMID "$EXTRACTED_PATH" $VOLUME
if [ $? -ne 0 ]; then
  echo "Error: Failed to import the disk."
  exit 1
fi

# Attach the disk to the VM
echo "Attaching the disk..."
qm set $VMID --sata0 $VOLUME:vm-$VMID-disk-1 --boot c --scsihw virtio-scsi-pci --boot order=sata0
if [ $? -ne 0 ]; then
  echo "Error: Failed to attach the disk."
  exit 1
fi

# Resize disk
echo "Resize ZimaOS disk"
qm resize $VMID sata0 +8G
if [ $? -ne 0 ]; then
  echo "Error: Failed to resize the disk."
  exit 1
fi

# Start VM
echo "Starting VM..."
qm start $VMID

echo -e "\n${GREEN}ZimaOS VM creation completed successfully!${NC}"
