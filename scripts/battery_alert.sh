#!/bin/bash
userid=$(id -u)
DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$userid/bus"
export DBUS_SESSION_BUS_ADDRESS

capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
status="$(cat /sys/class/power_supply/BAT0/status)"

if (($capacity < 15 && $status == Discharging)); then
    notify-send "I'm hungry, feed me!" "Your battery is running out" -u critical
fi
