#!/bin/bash

# Todo
# - [ ] usage()
# - [ ] getopts()

if [ $# -lt 1 ]; then
  # List Wifi networks
  nmcli -p dev wifi
elif [ $# -eq 2 ]; then
  # Connect for first time
  nmcli dev wifi con "$1" password "$2"
elif [ $# -eq 3 ]; then
  # Connect for first time and save network
  nmcli dev wifi con "$1" password "$2" name "$3"
elif [ $# -eq 1 ]; then
  if [ $1 == "disconnect" ]; then
    nmcli dev disconnect wlp3s0
  else
    # Connect to existing profile OR connect to passwordless network
    nmcli con up id "$1" || nmcli dev wifi con "$1"
  fi
fi
