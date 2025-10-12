#!/bin/bash
UPTIME_PRETTY=$(uptime -p)

UPTIME_FORMATTED=$(echo "$UPTIME_PRETTY" | sed 's/^up //;s/,*$//;s/minute/m/; s/hour/h/; s/day/d/; s/s//g')

echo " $UPTIME_FORMATTED"
