# Yocto Build and Write Image

This repository provides scripts to build a Yocto image and write it to an SD card for Raspberry Pi 3 (64-bit). The process involves using Yocto's kirkstone version and adding a custom layer with a simple web server.

## Prerequisites

Make sure you have the necessary dependencies installed on your system:

- Git
- Bmaptool
- Yocto dependencies (check Yocto documentation)

## Step 1: Clone the Repository

```
git clone https://github.com/mhsoftware100/Yocto-RPi3-WebServer.git
cd Yocto-RPi3-WebServer
```

## Step 2: Build Yocto Image

The build_yocto_image.sh script automates the Yocto image building process. It performs the following steps:

1. Clone Yocto and Raspberry Pi layers if not already cloned.
1. Create a custom layer named mywebserver.
1. Add Raspberry Pi layer (meta-raspberrypi).
1. Add a service and mywebserver recipe to the mywebserver layer.
1. Edit local.conf in build/conf/local.conf.
1. Run bitbake core-image-minimal.
1. Prompt to manually run the write_image.sh script to write the image to the SD card.
1. Boot and test the Raspberry Pi.

```
    ./build_yocto_image.sh
```

## Step 3: Write Yocto Image to SD Card

The write_image.sh script writes the Yocto image to the SD card. It performs the following steps:

1. Check if the image file and bmap file exist.
1. Confirm with the user before proceeding.
1. Unmount the device if already mounted.
1. Run bmaptool to write the image to the SD card.

```
./write_image.sh /dev/sdX
```

Replace /dev/sdX with the actual device path for your SD card.

Note: Ensure that the SD card is inserted before running the script.


Note

- If the Yocto directory (yocto-kirkstone) already exists, the build_yocto_image.sh script continues from Step 8.
- Dependencies and Yocto prerequisites must be installed before running the scripts.
- For detailed information, refer to the comments in the scripts.

