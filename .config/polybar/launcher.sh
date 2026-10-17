#!/bin/sh

killall -q polybar

echo "___" | tee -a /tmp/polybar1.log /tmp /tmp/polybar2.log
polybar example 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Polybar launched..."
