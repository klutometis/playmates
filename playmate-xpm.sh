#!/usr/bin/env bash
max_width=640
max_height=480
colors=14
xpm=$(mktemp --suffix=.xpm)
gz=$(mktemp --suffix=.xpm.gz)
jpg=$1

function geometry() {
    identify $1 | cut -d ' ' -f 3
}

function width() {
    echo $1 | sed -e 's/\(.*\)x.*/\1/'
}

function height() {
    echo $1 | sed -e 's/.*x\(.*\)/\1/'
}

geometry=$(geometry $jpg)
width=$(width $geometry)
height=$(height $geometry)
if (( width > height )); then
    resize=x$max_height
else
    resize=${max_width}x
fi

# crop a random 640x480 section of the image (not necessarily tits or
# puss!)
convert $jpg -resize $resize -colors $colors $xpm && {   
    geometry=$(geometry $xpm)
    width=$(width $geometry)
    height=$(height $geometry)
    x=0
    y=0
    if (( width > height )); then
        x=$(( $RANDOM % ($width - $max_width) ))
    else
        y=$(( $RANDOM % ($height - $max_height) ))
    fi
    mogrify -crop ${max_width}x${max_height}+${x}+${y} $xpm
} && \
    gzip -c $xpm > $gz && \
    echo $gz || \
    exit 1