#!/bin/sh

pacman -Syu --noconfirm
pacman -S bluez bluez-utils python python-pip --noconfirm
systemctl start bluetooth.service
systemctl enable bluetooth.service

pacman -S wget git mercurial go --noconfirm

mkdir ~/gocode
echo GOPATH=~/gocode >> ~/.bashrc
echo GOPATH=~/gocode >> ~/.bash_profile
echo PATH=$PATH:$GOCODE/bin >> ~/.bashrc
echo PATH=$PATH:$GOCODE/bin >> ~/.bash_profile

go get github.com/revel/revel
go get github.com/revel/cmd/revel
go get github.com/stianeikeland/go-rpio

go version
revel

