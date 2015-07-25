#!/bin/bash

##
# Check SDCard device path.
#
[ -z "${1+x}" ]
ret=${?}
if [ ${ret} -eq 0 ]; then
    echo "SDCard device path is not set."
    exit 1
fi
echo SDCard device path is $1.
SDCARD_PATH=$1
BOOT_PARTITION_PATH=${SDCARD_PATH}1
ROOT_PARTITION_PATH=${SDCARD_PATH}2

#
# Check NIC IP address.
#
[ -z "${2+x}" ]
ret=${?}
if [ ${ret} -eq 0 ]; then
    echo IP Address is not set for systemd-networkd.
    exit 1
fi
echo IP Address is $2

#
# Check NIC gateway address.
#
[ -z "${3+x}" ]
ret=${?}
if [ ${ret} -eq 0 ]; then
    echo NIC gateway Address is not set for systemd-networkd.
    exit 1
fi
echo Gateway address is $3

#
# Check NIC DNS address.
#
[ -z "${4+x}" ]
ret=${?}
if [ ${ret} -eq 0 ]; then
    echo NIC DNS Address is not set for systemd-networkd.
    exit 1
fi
echo DNS Address is $4

NIC_CONFIG_PATH=root/etc/systemd/network/eth0.network
NIC_IPADDR=$2
NIC_GATEWAY=$3
NIC_DNS=$4

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

echo "Create partition on SDCARD."

fdisk ${SDCARD_PATH} <<\__EOF__
o
n
p
1

+100M
t
c
a
n
p
2


t
2
83
w
__EOF__

sleep 2

#
# Create Arch Linux ARM on SDCard.
#
mkdir boot root
echo "Create filesystem and bootloader on SDCARD."

mkfs.vfat ${BOOT_PARTITION_PATH}
sleep 2s
mount ${BOOT_PARTITION_PATH} boot
mkfs.f2fs ${ROOT_PARTITION_PATH}
sleep 2s
mount ${ROOT_PARTITION_PATH} root
bsdtar -xpf ./${IMAGE_FILE_NAME} -C root
sync

mv root/boot/* boot

#
# Settings
#
echo "Copy initial setup script file."
cp -f ./settings/setup.sh root/setup.sh

echo "Setting static ip address for systemd-networkd."
echo NIC IP address is ${NIC_IPADDR}
echo NIC Gateway address is ${NIC_GATEWAY}
echo NIC DNS address is ${NIC_DNS}

echo "[Match]" > ${NIC_CONFIG_PATH}
echo "Name=eth0" >> ${NIC_CONFIG_PATH}
echo "[Network]" >> ${NIC_CONFIG_PATH}
echo "DHCP=none" >> ${NIC_CONFIG_PATH}
echo "DNS=${NIC_DNS}" >> ${NIC_CONFIG_PATH}
echo "[Address]" >> ${NIC_CONFIG_PATH}
echo "Address=${NIC_IPADDR}/24" >> ${NIC_CONFIG_PATH}
echo "[Route]" >> ${NIC_CONFIG_PATH}
echo "Gateway=${NIC_GATEWAY}" >> ${NIC_CONFIG_PATH}

#
# Finalize
#
umount boot root
rm -rf boot root
#rm ${IMAGE_FILE_NAME} <-- better not delete...?

echo "Done!"
echo "Please remove SDCard, and insert your Raspberry Pi. Enjoy!"
