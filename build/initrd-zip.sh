#!/bin/bash

cd unpacked-initrd
find ./ | cpio -H newc -o > /tmp/initrd
gzip -9 /tmp/initrd
cd ../..
mv /tmp/initrd.gz ubuntu-installer/amd64/
rm -Rf unpacked-initrd