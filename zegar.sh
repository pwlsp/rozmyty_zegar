#!/usr/bin/bash
declare -i h
declare -i m
# hh = `date +%H`
h=$((`date +%H`))
m=$((`date +%M`))

echo $h
echo $m
echo $(($h+$m))