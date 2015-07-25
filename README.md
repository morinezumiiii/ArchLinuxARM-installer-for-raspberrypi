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
$ sudo ./install.sh [sdcard device path] [IP address(IPv4)] [Gateway] [DNS]
```

example

```
$ sudo ./install.sh /dev/sdb 192.168.43.11 192.168.43.1 192.168.43.1
```

3. Remove SDCard, insert your Raspberry Pi, and power on.
4 Connect Raspberry Pi via SSH, 


# More info

Please read official site.

http://archlinuxarm.org/platforms/armv6/raspberry-pi
