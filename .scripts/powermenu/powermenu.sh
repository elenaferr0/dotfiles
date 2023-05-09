#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n\uf51c AirplaneMode\n Logout" | wofi -i --dmenu -c $HOME/.config/wofi/powermenu_config -s $HOME/.config/.scripts/powermenu/powermenu.css | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
                ~/.config/.scripts/lockscreen
                ;;
        logout)
                killall Hyprland
                ;;
        airplanemode)
                ~/.config/.scripts/toggle_airplane_mode.sh
                ;;
esac
