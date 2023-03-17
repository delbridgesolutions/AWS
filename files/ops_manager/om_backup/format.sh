#!/bin/bash
sudo mkfs -t xfs /dev/sdh
sudo mkdir /backups
sudo mkdir /backups/head
sudo mount /dev/sdh /backups/head
sudo grep -q /dev/sdh /etc/fstab || echo "/dev/sdh      /backups/head          xfs     defaults,noatime   1  1" | sudo tee --append /etc/fstab
