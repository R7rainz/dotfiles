#!/bin/bash

# Simple countdown Pomodoro timer (default 25 minutes)
TIMER_FILE="/tmp/pomodoro_timer"

if [[ "$1" == "toggle" ]]; then
	if [[ -f $TIMER_FILE ]]; then
		rm $TIMER_FILE
	else
		echo $((25 * 60 + $(date +%s))) >$TIMER_FILE
	fi
	exit 0
fi

if [[ -f $TIMER_FILE ]]; then
	END=$(cat $TIMER_FILE)
	NOW=$(date +%s)
	REM=$((END - NOW))
	if ((REM > 0)); then
		MIN=$((REM / 60))
		SEC=$((REM % 60))
		printf '{"text":"%02d:%02d","class":"work"}\n' $MIN $SEC
	else
		rm $TIMER_FILE
		echo '{"text":"Break","class":"break"}'
	fi
else
	echo '{"text":"Pomodoro","class":"idle"}'
fi
