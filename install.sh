#!/bin/sh

#
# Check SDCard device path.
#
[ -z "${1+x}" ]
ret=${?}
echo ${ret}
if [ ${ret} -eq 0 ]; then
    echo "SDCard device path is not set."
    exit 1
fi
echo SDCard device path is $1.
SDCARD_PATH=$1
BOOT_PARTITION_PATH=${SDCARD_PATH}1
ROOT_PARTITION_PATH=${SDCARD_PATH}2

#
# Check IP address.
#
[ -z "${2+x}" ]
ret=${?}
echo ${ret}
if [ ${ret} -eq 0 ]; then
    echo IP Address is not set for systemd-networkd.
    exit 1
fi
echo IP Address is $2

#
# Check and download Arch Linux ARM image.
#
IMAGE_FILE_NAME=ArchLinuxARM-rpi-latest.tar.gz
IMAGE_URL=http://archlinuxarm.org/os/${IMAGE_FILE_NAME}
if [ -f "./${IMAGE_FILE_NAME}" ]; then
    echo "${IMAGE_FILE_NAME} found."
else
    echo "${IMAGE_FILE_NAME} not found."
    echo "Download latest image..."
    wget ${IMAGE_URL}
fi

#
# Create Arch Linux ARM on SDCard.
#
#mkdir boot root
echo "Create filesystem and bootloader on SDCARD."

#mkfs.vfat ${BOOT_PARTITION_PATH}
#mount ${BOOT_PARTITION_PATH} boot
#mkfs.f2fs ${ROOT_PARTITION_PATH}
#mount ${ROOT_PARTITION_PATH} root
#bsdtar -xpf ${IMAGE_FILE_PATH} -C root
#sync

#mv root/boot/* boot

#
# Settings
#
echo "Setting static ip address for systemd-networkd. ${IP_ADDRESS}"
#cp -f ./settings/systemd-networkd/eth0.network.$2 root/etc/systemd/network/eth0.network

#
# Finalize
#
#umount boot root
#rm -rf boot root
#rm ${IMAGE_FILE_NAME}

echo "Done!"
echo "Please remove SDCard, and insert your Raspberry Pi. Enjoy!"
