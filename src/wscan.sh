#!/bin/bash

# Todo
# - [ ] usage()
# - [ ] getopts()

if [ $# -lt 1 ]; then
  # List Wifi networks
  nmcli dev wifi
elif [ $# -eq 2 ]; then
  # Connect for first time
  nmcli dev wifi con "$1" password caffeine name "$2"
elif [ $# -eq 1 ]; then
  # Connect to existing profile
  nmcli con up id "$1"
fi
