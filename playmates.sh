#!/usr/bin/env bash
url_playmates=$(mktemp)
curl -s http://igorkazakov.ru/playboy/ | \
    tidy -asxml -numeric -q --show-warnings no | \
    xml fo | \
    xml sel -N x="http://www.w3.org/1999/xhtml" \
    -t -m "//x:td[x:a]" -v "x:a/@href" -o "|" -v "x:small" -n | \
    # remove trailing line artifact
    head -n -1 > \
    ${url_playmates}

while read url_playmate; do
    url=$(echo $url_playmate | cut -d "|" -f 1)
    playmate=$(echo $url_playmate | \
        cut -d "|" -f 2 | \
        tr [:upper:] [:lower:])
    year=$(echo $url | grep -E -o '[[:digit:]]{4}')
    month=$(echo $url | sed -n -E -e 's/.*_([[:alpha:]]+)\.jpg/\1/p')
    # marilyn
    : ${month:=february}
    date=$(date -d "1 $month $year" +"%Y %m")
    filename=$(echo $date $playmate.jpg | tr ' ' '-')
    wget -c -O $filename $url
done < ${url_playmates}
