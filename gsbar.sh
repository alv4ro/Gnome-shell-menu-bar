#!/bin/bash

REFLEXION="'gnome-shell-reflection@emergya.com'"
STRING=`gsettings get org.gnome.shell enabled-extensions | sed 's/.\(.*\)/\1/' | sed 's/\(.*\)./\1/' | tr ', ' ' ' ; echo`
ACT=no

for i in $STRING; do
    if [ $i = $REFLEXION ]; then
        ACT=yes
    else
        STRING_UP="$STRING_UP,$i"
    fi

done

NO_REFLEXION=`echo $STRING_UP | sed 's/.\(.*\)/\1/'`

if [ $ACT = "yes" ];then
    VALUE="[$NO_REFLEXION]"
    if zenity --question --title="Barra de menú de Gnome-shell" --width=350 --text="¿Cambiar la barra de menú a la parte superior de la pantalla?"; then
        gsettings set org.gnome.shell enabled-extensions "$VALUE"
        gnome-shell --replace &
    fi

else
    VALUE="[$NO_REFLEXION,$REFLEXION]"
    if zenity --question --title="Barra de menú de Gnome-shell" --width=350 --text="¿Cambiar la barra de menú a la \nparte inferior de la pantalla?"; then
        gsettings set org.gnome.shell enabled-extensions "$VALUE"
    fi
fi
