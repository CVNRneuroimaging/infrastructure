CREATE WHEEZY INSTALL MEDIA
============================

Here is how to create wheezy USB install media using a mac. In
March 2014 this produced a bootable USB install thumbdrive that performed bug-free
using the [debian graphical installer](http://debian-handbook.info/browse/stable/sect.installation-steps.html).
Does not suffer from [UNetbootin GRUB bugs](https://bugs.launchpad.net/unetbootin/+bug/532380).

1. Download the debian wheezy amd64 net install image, such as http://cdimage.debian.org/debian-cd/7.4.0/amd64/iso-cd/debian-7.4.0-amd64-netinst.iso

2. Follow [these instructions](http://www.ubuntu.com/download/desktop/create-a-usb-stick-on-mac-osx), more or less. Here's what that looked like on an OS X 10.9.2 host in March 2014:


```
stowler-rmbp:Downloads stowler$ ls debian-*-amd64-netinst*
debian-7.4.0-amd64-netinst.iso

stowler-rmbp:Downloads stowler$ md5 debian-*-amd64-netinst*
MD5 (debian-7.4.0-amd64-netinst.iso) = e7e9433973f082a297793c3c5010b2c5

stowler-rmbp:Downloads stowler$ hdiutil convert -format UDRW -o debian-7.4.0-amd64-netinst.img debian-7.4.0-amd64-netinst.iso 
Reading Driver Descriptor Map (DDM : 0)…
Reading Debian 7.4.0 amd64 1             (Apple_ISO : 1)…
Reading Apple (Apple_partition_map : 2)…
Reading Debian 7.4.0 amd64 1             (Apple_ISO : 3)…
..............................................................................
Reading EFI (Apple_HFS : 4)…
..............................................................................
Reading Debian 7.4.0 amd64 1             (Apple_ISO : 5)…
...........................................................................................................................................................................................................................................
Elapsed Time: 714.486ms
Speed: 310.7Mbytes/sec
Savings: 0.0%
created: /Users/stowler/Downloads/debian-7.4.0-amd64-netinst.img.dmg

stowler-rmbp:Downloads stowler$ mv debian-7.4.0-amd64-netinst.img.dmg debian-7.4.0-amd64-netinst.img

stowler-rmbp:Downloads stowler$ diskutil list
/dev/disk0
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *500.3 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:                  Apple_HFS Macintosh HD            499.4 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3

# ...and then I inserted my USB drive and re-ran this command, noting that the
# USB drive was assigned /dev/disk2:

stowler-rmbp:Downloads stowler$ diskutil list
/dev/disk0
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *500.3 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:                  Apple_HFS Macintosh HD            499.4 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
/dev/disk2
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *8.0 GB     disk2
   1:               Windows_NTFS Untitled                8.0 GB     disk2s1

stowler-rmbp:Downloads stowler$ diskutil unmountDisk /dev/disk2

stowler-rmbp:Downloads stowler$ sudo dd if=debian-7.4.0-amd64-netinst.img of=/dev/rdisk2 bs=1m
Password:
222+0 records in
222+0 records out
232783872 bytes transferred in 27.264538 secs (8537972 bytes/sec)

# After that command completes ignore any GUI pop-up messages about invalid disks, and just physically remove the USB drive.
```

