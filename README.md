ubuntu-netboot-tftp
===================

Automating server installation, before being configurable by
[hadoop-ansible](https://github.com/analytically/hadoop-ansible) - using the [Ubuntu](http://www.ubuntu.com) 13.10
netboot image, using only [TFTP](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol).

### Requirements

- TFTP server (see below)
- DHCP server

### Usage

- customize `hostnames` (mac address to hostname mappings)
- customize `preseed.cfg` with your values

### PXE

The PXE boot automates server installation. We use a [preseed config](preseed.cfg) delivered over [TFTP](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol).
See `ubuntu-installer/amd64/boot-screens/txt.cfg` (line 6).

#### Setup with [pfSense](http://www.pfsense.org/) (tested on versions 2.0.3 and 2.1)

- Install the TFTP package (`System` > `Packages`)
- Under `System` > `Advanced` > `Firewall / NAT` deselect any interface for `TFTP Proxy` and save
- Under `Services` > `TFTP` select the LAN interface for `TFTP Daemon Interfaces` and save
- SSH into your pfSense appliance (enable SSH access and add a rule to allow port 22)
- Install curl: `pkg_add -r curl` and rehash: `rehash`
- `curl -sL https://github.com/analytically/ubuntu-netboot-tftp/tarball/master | tar -xf -`
- `cd analytically-ubuntu-netboot-tftp-4753507ab5c9bca0599c85f0401108c1059da0c9/` (the directory has another hash)
- `mv analytically-ubuntu-netboot-tftp-4753507ab5c9bca0599c85f0401108c1059da0c9/* /tftpboot`
- `rm -R analytically-ubuntu-netboot-tftp-4753507ab5c9bca0599c85f0401108c1059da0c9`
- Configure `Enable network booting` under the LAN DHCP server config under `Services` > `DHCP Server`, see below:

![tftp booting](images/tftpboot.png)

### After installation

- SSH Password: PQmb6JxU
- continue with my [Hadoop Ansible Playbook](https://github.com/analytically/hadoop-ansible)

### Warning

The `ubuntu-installer/amd64/initrd.gz` archive contains a workaround to get TFTP and preseed.cfg working together (see `/usr/lib/fetch-url/tftp`)
with [pfSense](http://www.pfsense.org/). The bug in `debian-installer-utils` is reported [here](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=707955).

### License

Licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Copyright 2013 [Mathias Bogaert](mailto:mathias.bogaert@gmail.com).