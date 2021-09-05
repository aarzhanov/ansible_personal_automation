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

timedatectl status
timedatectl set-ntp true

loadkeys de-latin1

read -r -p "Enter the users and encryptions password: " password_for_user_and_encrypt
sed -i "s/password_to_replace/${password_for_user_and_encrypt}/g" "${ARCH_INST_CONF}"

archinstall --config "${ARCH_INST_CONF}" --silent

