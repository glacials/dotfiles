#!/bin/bash
# Credit to rent0n from https://bbs.archlinux.org/viewtopic.php?pid=694190#p694190

command=$1

if [ "$command" = "" ]; then
	echo "usage: $0 {up|down|toggle}"
	exit 0;
fi

display_volume=0

if [ "$command" = "up" ]; then
	display_volume=$(amixer sset Master 8+ unmute | grep -m 1 "%]" | cut -d "[" -f2|cut -d "%" -f1)
fi

if [ "$command" = "down" ]; then
	display_volume=$(amixer sset Master 8- unmute | grep -m 1 "%]" | cut -d "[" -f2|cut -d "%" -f1)
fi

icon_name=""

if [ "$command" = "toggle" ]; then
	if amixer get Master | grep "\[on\]"; then
		amixer sset Master mute
		display_volume=0
	else
		amixer sset Master unmute
		display_volume=$(amixer get Master | grep -m 1 "%]" | cut -d "[" -f2|cut -d "%" -f1)
	fi
fi

notify-send "Volume: $display_volume%"
exit 1
