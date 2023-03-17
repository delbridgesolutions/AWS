#!/bin/bash
echo "Formatting Filesystem"
sudo mkfs -t xfs /dev/sdf
sudo mkdir /data
sudo mount /dev/sdf /data
sudo grep -q /dev/sdf /etc/fstab || echo "/dev/sdf       /data          xfs     defaults,noatime   1  1" | sudo tee --append /etc/fstab

sudo mkfs -t xfs /dev/sdg
sudo mkdir /s3metadata
sudo mount /dev/sdg /s3metadata
sudo grep -q /dev/sdg /etc/fstab || echo "/dev/sdg       /s3metadata          xfs     defaults,noatime   1  1" | sudo tee --append /etc/fstab
