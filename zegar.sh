#!/usr/bin/bash

declare -a godzina_mianownik=(
    " " pierwsza druga trzecia czwarta piąta szósta siódma ósma dziewiąta
    dziesiąta jedenasta dwunasta trzynasta czternasta piętnasta szestnasta siedemnasta osiemnasta dziewiętnasta
    dwudziesta "dwudziesta pierwsza" "dwudziesta druga" "dwudziesta trzecia" " "
)

declare -a godzina_dopelniacz=(
    "północy" "pierwszej" "drugiej" "trzeciej" "czwartej" "piątej" "szóstej" "siódmej" "ósmej" "dziewiątej" "dziesiątej"
    "jedenastej" "dwunastej" "trzynastej" "czternastej" "piętnastej" "szesnastej" "siedemnastej" "osiemnastej" "dziewiętnastej"
    "dwudziestej" "dwudziestej pierwszej" "dwudziestej drugiej" "dwudziestej trzeciej" "północy"
)

declare -a minuta_mianownik=(" " "jeden" "dwa" "trzy" "cztery" "pięć" "sześć" "siedem" "osiem" "dziewięć"
"dziesięć" "jedenaście" "dwanaście" "trzynaście" "czternaście" "piętnaście" "szesnaście" "siedemnaście" "osiemnaście" "dziewiętnaście"
"dwadzieścia" "dwadzieścia jeden" "dwadzieścia dwa" "dwadzieścia trzy" "dwadzieścia cztery" "dwadzieścia pięć" "dwadzieścia sześć" "dwadzieścia siedem" "dwadzieścia osiem" "dwadzieścia dziewięć"
"trzydzieści" "trzydzieści jeden" "trzydzieści dwa" "trzydzieści trzy" "trzydzieści cztery" "trzydzieści pięć" "trzydzieści sześć" "trzydzieści siedem" "trzydzieści osiem" "trzydzieści dziewięć"
"czterdzieści" "czterdzieści jeden" "czterdzieści dwa" "czterdzieści trzy" "czterdzieści cztery" "czterdzieści pięć" "czterdzieści sześć" "czterdzieści siedem" "czterdzieści osiem" "czterdzieści dziewięć"
"pięćdziesiąt" "pięćdziesiąt jeden" "pięćdziesiąt dwa" "pięćdziesiąt trzy" "pięćdziesiąt cztery" "pięćdziesiąt pięć" "pięćdziesiąt sześć" "pięćdziesiąt siedem" "pięćdziesiąt osiem" "pięćdziesiąt dziewięć"
)

help(){
    echo pomoc
}

dokladna(){
    local hour=$1
    local minute=$2
    if (($hour != 0)); then
        echo "godz. ${godzina_mianownik[$hour]} ${minuta_mianownik[$minute]}"
    else
        echo "godz. ${minuta_mianownik[$minute]} po północy"
    fi
}

do_pol(){
    local hour=$1
    local minute=$2
    # jakie przedziały tu mają być bo coś się nie zgadza w jego opisie
}

do_godziny(){
    local hour=$1
    local minute=$2
    # hour=0
    # minute=29
    if ((minute >= 30)); then
        hour=$(($hour+1))
    fi
    echo "około ${godzina_dopelniacz[$hour]}"
}

declare mode=$1
declare -i hour
declare -i minute

hour=$((10#$(date +%H)))
minute=$((10#$(date +%M)))
# bo gdy minuta/godzina była np. 09 to uznawało to za 9 w systemie oktalnym (error: value to great for base)

# jeżeli bez parametrów
if (($# == 0)); then
    dokladna $hour $minute

#jeżeli z parametrami
else
    case $1 in
        -h | --help) help;;
        -p | --do-pol) do_pol $hour $minute;;
        -g | --do-godziny) do_godziny $hour $minute;;
    esac
fi