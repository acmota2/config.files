#!/bin/zsh

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ sub(/%/,X,$5); print $5 }')
verifyMuted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)
valid=#00dfdf
invalid=#666666
volume='\xf057e'

if [[ $verifyMuted == 'MUTED' ]]; then
    print '<fc=#ff0000>   NOPE   </fc>'
else
    case $(expr $vol / 10) in
        0) print "<fn=2>${1}</fn>" 0$vol% "<fc=$invalid>▒▒▒▒▒▒▒▒▒▒</fc>" ;;
        1) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>█<fc=$invalid>▒▒▒▒▒▒▒▒▒</fc></fc>" ;;
        2) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>██</fc><fc=$invalid>▒▒▒▒▒▒▒▒</fc>" ;;
        3) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>███</fc><fc=$invalid>▒▒▒▒▒▒▒</fc>" ;;
        4) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>████</fc><fc=$invalid>▒▒▒▒▒▒</fc>" ;;
        5) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>█████</fc><fc=$invalid>▒▒▒▒▒</fc>" ;;
        6) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>██████</fc><fc=$invalid>▒▒▒▒</fc>" ;;
        7) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>███████</fc><fc=$invalid>▒▒▒</fc>" ;;
        8) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>████████</fc><fc=$invalid>▒▒</fc>" ;;
        9) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>█████████</fc><fc=$invalid>▒</fc>" ;;
        *) print "<fn=2>${1}</fn>" $vol% "<fc=$valid>██████████</fc>" ;;
    esac
fi
