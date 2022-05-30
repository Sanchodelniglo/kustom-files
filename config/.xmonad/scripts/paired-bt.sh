#!/bin/bash

green="#2de0a7"
white="#ffffff"
device_name=`bluetoothctl info | sed -n 's/.*Name://p'`

if [[ $device_name != "" ]]; then
	echo "<fc=$green>$device_name</fc>"
else
	echo "<fc=$white></fc>"
fi