#!/bin/bash

green="#2de0a7"
yellow="#f1fa8c"
red="#ff5555"

capacity=`cat /sys/class/power_supply/BAT0/capacity`
status=`cat /sys/class/power_supply/BAT0/status`

if [[ $status == "Discharging" ]]; then
    if (( $capacity >= 75 )); then
        echo "<fc=$green> $capacity</fc>%"
    elif (( $capacity >= 50 )); then
        echo "<fc=$green> $capacity</fc>%"
    elif (( $capacity >= 25 )); then
        echo "<fc=$green> $capacity</fc>%"
    elif (( $capacity >= 10 )); then
        echo "<fc=$yellow> $capacity</fc>%"
    else
        echo "<fc=$red> $capacity</fc>%"
    fi
else
    if (( $capacity == 100 )); then
        echo "<fc=$green> $capacity</fc>%"
    elif (( $capacity >= 80 )); then
        echo "<fc=$green> $capacity</fc>%"
    elif (( $capacity >= 60 )); then
        echo "<fc=$green> $capacity</fc>%"
    elif (( $capacity >= 30 )); then
        echo "<fc=$green> $capacity</fc>%"
    else
        echo "<fc=$green> $capacity</fc>%"
    fi
fi