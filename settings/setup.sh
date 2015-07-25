#!/bin/sh

pacman -Syu --noconfirm
pacman -S bluez bluez-utils python python-pip --noconfirm
systemctl start bluetooth.service
systemctl enable bluetooth.service

pacman -S openssh --noconfirm
systemctl start sshd.service
systemctl enable sshd.service
