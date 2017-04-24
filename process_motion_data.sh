#!/bin/bash
X_DATA=$(cat $1 | cut -d ':' -f 4 | cut -d ',' -f 1 | tr '\n' ',');
Y_DATA=$(cat $1 | cut -d ':' -f 4 | cut -d ',' -f 2 | tr '\n' ',');
Z_DATA=$(cat $1 | cut -d ':' -f 4 | cut -d ',' -f 3 | tr '\n' ',');
echo "$1_x=$X_DATA" > $1_data.m
echo "$1_y=$Y_DATA" >> $1_data.m
echo "$1_z=$Z_DATA" >> $1_data.m
