#!/bin/bash
echo "Formatting Filesystem"
sudo mkfs -t xfs /dev/xvda
sudo mkdir /data
sudo mount /dev/xvda /data
sudo grep -q /dev/xvda /etc/fstab || echo "/dev/xvda       /data          xfs     defaults,noatime   1  1" | sudo tee --append /etc/fstab
