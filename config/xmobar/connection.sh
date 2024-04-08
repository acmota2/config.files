#!/bin/zsh

cable=$(cat /sys/class/net/${1}/carrier)
ssid=$(nmcli -t -f active,ssid dev wifi| cut -d\' -f2 | grep -oP 'yes:\K.+')

if [[ $? != 0 ]] && [[ $cable == 0 ]]; then
    print "<fc=#ff0000><fn=2>${2}</fn> No connection</fc>"
    return 0
fi

strength=$(nmcli dev wifi list | awk '/\*/{if (NR!=1) {print $6}}')
if [[ $cable == 1 ]]; then
    print $(ip -json route get 8.8.8.8 | jq -r '.[].prefsrc')
else
    case $(expr $strength / 25) in
        0) $icon="<fn=2>${3}</fn>" ;;
        1) $icon="<fn=2>${4}</fn>" ;;
        2) $icon="<fn=2>${5}</fn>" ;;
        *) $icon="<fn=2>${6}</fn>" ;;
    esac

    print "<fc=#ffffff>$icon</fc> $ssid"
fi
