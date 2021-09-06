#!/usr/bin/env bash
###############################################################################
# Use Bash Strict Mode
set -o errexit
set -o nounset
set -o pipefail
#set -o errtrace
set -o xtrace
IFS=$'\n\t'
###############################################################################

ARCH_INST_CONF="arch_minimal.json"
HOSTNAME="dell-xps"
USER="aarzhan"

# Check the timedatectl service status
timedatectl status
# Use timedatectl to ensure the system clock is accurate
timedatectl set-ntp true

# Set a German keyboard layout
loadkeys de-latin1

# Read users and encryptions password to variable, rewrite password in .json
read -r -p "Enter the users and encryptions password: " password_for_user_and_encrypt
sed -i "s/password_to_replace/${password_for_user_and_encrypt}/g" "${ARCH_INST_CONF}"

# Install base system with archinstall
archinstall --config "${ARCH_INST_CONF}" --silent

# Set timezone
arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime"
arch-chroot /mnt /bin/bash -c "hwclock --systohc"

# Set the keyboard layout, make the changes persistent in vconsole.conf
arch-chroot /mnt /bin/bash -c "sed -i 's/^KEYMAP.*/KEYMAP=de-latin1/' /etc/vconsole.conf"

# Set hosts
arch-chroot /mnt /bin/bash -c "echo '127.0.0.1    localhost' > /etc/hosts"
arch-chroot /mnt /bin/bash -c "echo '::1    localhost' >> /etc/hosts"
arch-chroot /mnt /bin/bash -c "echo '127.0.1.1    ${HOSTNAME}.localdomain    ${HOSTNAME}' >> /etc/hosts"
arch-chroot /mnt /bin/bash -c "echo '' >> /etc/hosts"

# Generating initramfs
#arch-chroot /mnt /bin/bash -c "sed -i 's/^HOOKS.*/HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)/' /etc/mkinitcpio.conf"
#arch-chroot /mnt /bin/bash -c "mkinitcpio -P linux"

arch-chroot /mnt /bin/bash -c "useradd -m -G wheel,video ${USER}"
