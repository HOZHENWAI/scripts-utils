#!/bin/bash

# Get the list of disk names
disk_names=$(lsblk -d -o NAME,TYPE | awk '$2 == "disk" {print $1}')

# Check if there are disks
if [ -z "$disk_names" ]; then
    echo "No disks found."
    exit 1
fi

# Loop through each disk and get temperature using hddtemp
for disk in $disk_names; do
    temperature=$(sudo hddtemp /dev/$disk 2>/dev/null)

    if [ -n "$temperature" ]; then
        echo "Temperature of $disk: $temperature"
    else
        echo "Failed to retrieve temperature for $disk."
    fi
done
