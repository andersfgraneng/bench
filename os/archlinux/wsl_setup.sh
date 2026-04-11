#!/bin/bash

# Use this file to create a default user that gets put in the sudo wheel.
# It also writes the default user to wsl.conf
# Remember to edit the sudoers file with visudo to ensure the wheel group has access
# Install required tools before running this script
# pacman -Sy git sudo vi

if [[ -z "$1" ]];then
    echo "Username cannot be blank"
else
    useradd -G wheel -m $1
    echo -e "[user]\ndefault=$1" >> /etc/wsl.conf
    passwd $1
fi
