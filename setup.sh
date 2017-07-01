#!/bin/sh

# setup wifi (if necessary)
if [ ! -f /lib/firmware/brcm/brcmfmac4356-pcie.txt ]; then
  cp roles/wifi/files/brcmfmac4356-pcie.txt /lib/firmware/brcm/brcmfmac4356-pcie.txt
  modprobe -r brcmfmac
  modprobe brcmfmac

  # prompt for wifi connection
  echo "Please connect to a WiFi network, then press return to continue:"
  read
fi

# install ansible (if necessary)
if [ ! -f /usr/bin/ansible ]; then
  apt-get update
  apt-get -y dist-upgrade
  apt-get -y install ansible
fi

# run ansible scripts (without cowsay! :P)
ANSIBLE_NOCOWS=1 ansible-playbook main.yml