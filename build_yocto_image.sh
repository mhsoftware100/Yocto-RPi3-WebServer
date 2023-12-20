#!/bin/bash

# build_yocto_image.sh

# Check if yocto-kirkstone directory exists
if [ -d "yocto-kirkstone" ]; then
    echo "Yocto directory (yocto-kirkstone) already exists. Continuing from step 8."

    cd yocto-kirkstone
    source oe-init-build-env build
else
    # Step 1: Clone Yocto (kirkstone version)
    git clone -b kirkstone git://git.yoctoproject.org/poky.git yocto-kirkstone
    cd yocto-kirkstone

    # Step 2: Clone meta-raspberrypi layer
    git clone git://git.yoctoproject.org/meta-raspberrypi -b kirkstone

    # Step 3: Prepare environment variables
    source oe-init-build-env build

    # Step 4: Create a layer named mywebserver
    bitbake-layers create-layer ../meta-mywebserver
    bitbake-layers add-layer ../meta-mywebserver

    # Step 5: Add the Raspberry Pi layer (meta-raspberrypi)
    bitbake-layers add-layer ../meta-raspberrypi

    # Step 6: Add the service and mywebserver recipe to the mywebserver layer
    # Copy mywebserver.bb, mywebserver.service, and index.html to meta-mywebserver/recipes-example/mywebserver/
    mkdir -p ../meta-mywebserver/recipes-example/mywebserver/files
    cp ../../mywebserver.bb ../meta-mywebserver/recipes-example/mywebserver/
    cp ../../mywebserver.service ../meta-mywebserver/recipes-example/mywebserver/files/
    cp ../../index.html ../meta-mywebserver/recipes-example/mywebserver/files/

    # Step 7: Edit local.conf in build/conf/local.conf directory and add these variables
    echo 'IMAGE_INSTALL:append = " mywebserver python3"
    DISTRO_FEATURES:append = " systemd"
    MACHINE = "raspberrypi3-64"
    RPI_USE_U_BOOT = "1"
    ENABLE_UART = "1"
    INIT_MANAGER = "systemd"' >> conf/local.conf
fi

# Step 8: Run bitbake core-image-minimal
bitbake core-image-minimal

# Step 9: Manually run the write_image.sh script to write the image to the SD card
echo "Please run the write_image.sh script manually to write the Yocto image to your SD card."
echo "For example, execute: ./write_image.sh /dev/sda"

# Step 10: Boot and test
