#!/bin/bash

# write_image.sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <device>"
  exit 1
fi

DEVICE=$1

# Define paths for the image file and its corresponding bmap file
IMAGE_FILE="yocto-kirkstone/build/tmp/deploy/images/raspberrypi3-64/core-image-minimal-raspberrypi3-64.wic.bz2"
BMAP_FILE="yocto-kirkstone/build/tmp/deploy/images/raspberrypi3-64/core-image-minimal-raspberrypi3-64.wic.bmap"

# Check if the image file and bmap file exist
if [ ! -e "$IMAGE_FILE" ] || [ ! -e "$BMAP_FILE" ]; then
  echo "Error: Image file or bmap file not found."
  echo "Image file path: $IMAGE_FILE"
  echo "Bmap file path: $BMAP_FILE"
  exit 1
fi

# Confirm with the user before proceeding
read -p "Insert your SD card ($DEVICE) and press Enter to start writing the image..."

# Unmount the device if mounted
sudo umount "$DEVICE"* > /dev/null 2>&1

# Run bmaptool to write the image
sudo bmaptool copy --bmap "$BMAP_FILE" "$IMAGE_FILE" "$DEVICE"

echo "Success! Your Yocto image has been written to $DEVICE."
