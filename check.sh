#!/bin/bash

SCOREBOARDURL="http://54.243.195.23/"
TEAM="07-0444"
STATE="TX"

teams=$(wget "$SCOREBOARDURL" --quiet -O- | grep "<tr class='clickable'" -)
stateteams=$(echo "$teams" | grep "<td>$STATE</td>")

LINE=$(echo "$teams" | awk "/$TEAM/ { print NR }")
TOTAL=$(echo "$teams" | wc -l | xargs | cut -f 1 -d " ")

STATELINE=$(echo "$stateteams" | awk "/$TEAM/ { print NR }")
STATETOTAL=$(echo "$stateteams" | wc -l | xargs | cut -f 1 -d " ")

TIME=$(echo "$teams" | grep "$TEAM" | sed "s/.*<td>TX<\/td><td>[0-9]*<\/td><td> *\([0-9:]*\)<\/td><td>\([0-9]*\).*/\1/")
POINTS=$(echo "$teams" | grep "$TEAM" | sed "s/.*<td>TX<\/td><td>[0-9]*<\/td><td> *\([0-9:]*\)<\/td><td>\([0-9]*\).*/\2/")

echo "Team $TEAM:"

echo -e "\tTime: $TIME \tPoints: $POINTS"
echo -e "\tOverall: \t$LINE out of $TOTAL"
echo -e "\tIn State $STATE: \t$STATELINE out of $STATETOTAL"

