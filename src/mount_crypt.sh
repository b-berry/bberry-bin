#!/bin/bash

# This script automounts and luksOpens entries in `/etc/fstab` and `/etc/cryptab` for post boot external device attachment
# Note: script must be run with sudo privilege

# Restart cryptsetup.target ie scan /etc/crypttab
systemctl restart cryptsetup.target

# Todo: Figure out this bit:
# Please enter password with the systemd-tty-ask-password-agent tool.

# Mount all entries in /etc/fstab
mount -a
