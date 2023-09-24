#!/bin/bash

DAY_MONTH=$(date '+%a, %b %d')

sketchybar --set $NAME icon="$DAY_MONTH" label="$(date '+%H:%M')"
