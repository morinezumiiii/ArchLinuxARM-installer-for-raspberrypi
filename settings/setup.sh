#!/bin/sh

pacman -Syu --noconfirm
pacman -S bluez bluez-utils python python-pip
systemctl start bluetooth.service
systemctl enable bluetooth.service
