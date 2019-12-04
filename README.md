# Description

Arch Linux ARM Install automation script for Raspberry Pi.

# Requirements

* bsdtar
* dosfs-tools
* f2fs-tools

# Usage

1. Insert your SDCard in host linux machine.
2. Run install.sh with arguments.

```
$ sudo ./install.sh [sdcard device path] [IP address(IPv4)] [Gateway] [DNS] [Raspberry Pi Model(1|2|3|4)]
```

example

```
$ sudo ./install.sh /dev/sdb 192.168.43.11 192.168.43.1 192.168.43.1 4
```

3. Remove SDCard, insert your Raspberry Pi, and power on.
4 Connect Raspberry Pi via SSH, 


# More info

Please read official site.

https://archlinuxarm.org/platforms/armv6/raspberry-pi

https://archlinuxarm.org/platforms/armv7/broadcom/raspberry-pi-2

https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3

https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4
