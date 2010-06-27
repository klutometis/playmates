#!/usr/bin/env bash
DIRECTORY=/usr/local/lib/playmates
SPLASH=/boot/grub/splash.xpm.gz

playmate=$(playmate-xpm $(playmate-random ${DIRECTORY}))
if [[ -n $playmate ]]; then
    sudo cp -v $playmate $SPLASH
fi
