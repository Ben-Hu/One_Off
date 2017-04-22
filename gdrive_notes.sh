#!/bin/bash
for file in $(ls); do if [ ! $(echo $file | grep -iE 'txt') ]; then mv $file $file.txt; fi; done
gdrive upload --recursive $(pwd)

