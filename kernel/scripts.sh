#!/bin/bash

make -j10 
make -j10 modules_install
genkernel --luks --btrfs --install --bootloader=grub2 initramfs
make install 
grub-mkconfig -o /boot/grub/grub.cfg

