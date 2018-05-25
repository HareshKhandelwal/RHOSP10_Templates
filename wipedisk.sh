#!/bin/bash
echo "Number of disks detected: $(lsblk -no NAME,TYPE,MOUNTPOINT | grep "disk" | awk '{print $1}' | wc -l)"
for DEVICE in `lsblk -no NAME,TYPE,MOUNTPOINT | grep "disk" | awk '{print $1}'`
do
  echo "Checking /dev/$DEVICE..."
  echo "Number of partitions on /dev/$DEVICE: $(expr $(lsblk -n /dev/$DEVICE | awk '{print $7}' | wc -l) - 1)"

  echo "Wiping disk /dev/${DEVICE}"
  sgdisk -Z /dev/${DEVICE}
  sgdisk -g /dev/${DEVICE}
done
