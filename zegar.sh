#!/usr/bin/bash
declare mode=$1
declare -i hour
declare -i min

hour=$(date +%H)
min=$(date +%M)

echo $hour
echo $min

# jeżeli bez parametrów
if (($# == 0)); then
    echo "tak"
else
    echo "nie"
fi