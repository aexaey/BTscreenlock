#!/bin/bash

BTADDR="00:XX:XX:XX:XX:XX"
LOCKCMD="gnome-screensaver-command --activate"
# use UNLOCKCMD with caution! Anyone, who can emulate Bluetooth device
# with the same MAC address can unlock your PC!
UNLOCKCMD="gnome-screensaver-command --deactivate"
LOCKTHRESHOLD=-40
UNLOCKTHRESHOLD=-10
DEBUG=

RSSI=(0 0 0 0 $UNLOCKTHRESHOLD)
LOCKED=0
while true; do
	TMP=`hcitool rssi $BTADDR 2>&1`
	if [ "$TMP" == "Not connected." ]; then
		echo "reconnecting..."
		sudo hcitool cc $BTADDR
	fi
	TMP=`(hcitool rssi $BTADDR || echo x x x -30 ) 2>/dev/null | awk '{print $4;}'`
	RSSI=("${RSSI[@]:1}" $TMP)
	TMP=`echo ${RSSI[@]} | sed 's/ / + /g'`
	AVG=`expr $TMP`
	if [ $LOCKED -a $AVG -gt $UNLOCKTHRESHOLD ]; then
		LOCKED=0
		$UNLOCKCMD
	fi
	if [ !$LOCKED -a $AVG -lt $LOCKTHRESHOLD ]; then
		LOCKED=1
		$LOCKCMD
	fi
	if [ $DEBUG ]; then
		echo "$LOCKED: $AVG -> ${RSSI[@]}"
	fi
	usleep 300000;
done
