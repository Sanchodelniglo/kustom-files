#!/usr/bin/env bash

## Copyright (C) 2020-2021 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Kill already running process
_ps=(picom dunst ksuperkey mpd xfce-polkit xfce4-power-manager redshift)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
		sleep 1
	fi
done

# Fix cursor
xsetroot -cursor_name left_ptr

## Restore Pywal last colorscheme that was in use.
wal -R

## Restore Wallpaper
nitrogen --restore

## xfce4-settings daemon
xfsettingsd &

## polkit agent
if [[ ! `pidof xfce-polkit` ]]; then
	/usr/lib/xfce-polkit/xfce-polkit &
fi

## Enable power management
xfce4-power-manager &

## Start Compositing Manager
exec picom &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

## Notification Daemon
exec dunst &

## Start Music Player Daemon
exec mpd &

## Thunar Daemon
exec thunar --daemon &

# Enable fr keyboard layout for rofi
setxkbmap fr &

## start libinput-gestures
libinput-gestures-setup restart &

## redshift


dunstify "Xmonad Staaaaart !"
