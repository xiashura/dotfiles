#!/bin/bash

Notify=`dunstctl is-paused`
echo $Notify
if $Notify = false
then 
		dunstctl set-paused false
    notify-send "Notification enabled."
else
    notify-send "Notification disabled."
		sleep 3
		dunstctl set-paused true
fi
