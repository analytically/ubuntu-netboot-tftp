#!/bin/bash

mkdir unpacked-initrd
cd unpacked-initrd
gzip -dc ../../ubuntu-installer/amd64/initrd.gz | cpio -id