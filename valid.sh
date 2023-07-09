#!/bin/sh
# validation DNS response

isans=false
dig www.google.com | while read LINE
    if [ grep -E "ANSWER SECTION" $LINE ]; then
        isans=!$isans
    elif "$isans"; then
        awk '{print $1,$4,$5}' $LINE
    else
        # no action
        :
    fi
done
