#!/bin/bash

# This is hacky workaround to prevent screen sleep while watching media by running mouse activity
# for a set time. Default duration is approximately 3 hours.

set -e

echo "INFO: Getting system sleep time"
# This doesn't work
#GTIME=$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout)
GTIME=$(echo "60*8" | bc) # Setting to 8 minutes for now
if [ $? -gt 0 ]; then
  echo "Error: Failed to get system sleep time" && exit 1
fi

echo "INFO: Calculating iteration timer..." \
  && ITIME=$(echo "${GTIME}-5" | bc)
if [ $? -gt 0 ]; then
  echo "Error: Failed to set iteration timer" && exit 1
fi
echo "INFO: system sleep time: ${GTIME}"
echo "INFO: setting iteration time: ${ITIME}"

# Confirm GTIME less than an hour
if [ $GTIME -lt 3600 ]; then
  # Set default timer to 2 hours
  DEFAULT_TIMER=$(echo "((60*60*1)/${GTIME})*2" | bc)
else
  # Set to 2 GTIME
  DEFAULT_TIMER=$(echo "2*${GTIME}" | bc)
fi

loop_count=0
while [ $loop_count -lt $DEFAULT_TIMER ]; do
  echo "INFO: Initiated loop at ${loop_count}"
  echo "INFO: Sleep for: ${ITIME}s..." \
    && sleep $ITIME
  echo "INFO: Move mouse 0 0" \
    && xdotool mousemove 0 0
  echo "INFO: Move mouse 0 128" \
    && xdotool mousemove 0 128
  echo "INFO: Move mouse 0 0" \
    && xdotool mousemove 0 0
  echo "INFO: Sleep for: 5s..." \
    && sleep 5
  (( loop_count += 1 ))
done
