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

declare -a godzina_narzednik=(
    "północą" "pierwszą" "drugą" "trzecią" "czwartą" "piątą" "szóstą" "siódmą" "ósmą" "dziewiątą" "dziesiątą"
    "jedenastą" "dwunastą" "trzynastą" "czternastą" "piętnastą" "szesnastą" "siedemnastą" "osiemnastą" "dziewiętnastą"
    "dwudziestą" "dwudziestą pierwszą" "dwudziestą drugą" "dwudziestą trzecią" "północą"
)

declare -a minuta_mianownik=(
    " " "jeden" "dwa" "trzy" "cztery" "pięć" "sześć" "siedem" "osiem" "dziewięć"
    "dziesięć" "jedenaście" "dwanaście" "trzynaście" "czternaście" "piętnaście" "szesnaście" "siedemnaście" "osiemnaście" "dziewiętnaście"
    "dwadzieścia" "dwadzieścia jeden" "dwadzieścia dwa" "dwadzieścia trzy" "dwadzieścia cztery" "dwadzieścia pięć" "dwadzieścia sześć" "dwadzieścia siedem" "dwadzieścia osiem" "dwadzieścia dziewięć"
    "trzydzieści" "trzydzieści jeden" "trzydzieści dwa" "trzydzieści trzy" "trzydzieści cztery" "trzydzieści pięć" "trzydzieści sześć" "trzydzieści siedem" "trzydzieści osiem" "trzydzieści dziewięć"
    "czterdzieści" "czterdzieści jeden" "czterdzieści dwa" "czterdzieści trzy" "czterdzieści cztery" "czterdzieści pięć" "czterdzieści sześć" "czterdzieści siedem" "czterdzieści osiem" "czterdzieści dziewięć"
    "pięćdziesiąt" "pięćdziesiąt jeden" "pięćdziesiąt dwa" "pięćdziesiąt trzy" "pięćdziesiąt cztery" "pięćdziesiąt pięć" "pięćdziesiąt sześć" "pięćdziesiąt siedem" "pięćdziesiąt osiem" "pięćdziesiąt dziewięć"
)

help(){
    echo -e "[bez parametrów]\t\tGodzina dokładna"
    echo -e "-p   |  --do-pol\t\tDokładność do pół godziny"
    echo -e "-g   |  --do-godziny\t\tDokładność do godziny"
    echo -e "-n   |  --niedokladny\t\tNiedokładna godzina"
    echo -e "-a   |  --all\t\t\tWszystkie powyższe operacje"
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
    
    if (($hour == 0 && $minute == 0)); then
        echo "wybiła północ"
    elif (($minute == 0)); then
        echo "godzina ${godzina_mianownik[$hour]}"
    elif (($minute == 30)); then
        echo "w pół do ${godzina_dopelniacz[$hour+1]}"
    elif (($minute > 0 && $minute < 30)); then
        echo "po ${godzina_dopelniacz[$hour]}"
        # dopełniacz jest jak miejscownik w tym przypadku
    elif (($minute > 30 && $minute < 60)); then
        echo "przed ${godzina_narzednik[$hour+1]}"
    fi
}

do_godziny(){
    local hour=$1
    local minute=$2
    
    if ((minute >= 30)); then
        hour=$(($hour+1))
    fi
    echo "około ${godzina_dopelniacz[$hour]}"
}

niedokladny(){
    local hour=$1
    local minute=$2
    
    if (($hour >= 22 || $hour < 4)); then
        echo "noc"
    elif (($hour >= 4 && $hour < 7)); then
        echo "nad ranem"
    elif (($hour >= 7 && $hour < 10)); then
        echo "rano"
    elif (($hour >= 10 && $hour <12)); then
        echo "przed południem"
    elif (($hour >= 12 && $hour <17)); then
        echo "po południu"
    elif (($hour >=17 && $hour <22)); then
        echo "wieczór"
    fi
}

declare mode=$1
declare -i hour
declare -i minute

hour=$((10#$(date +%H)))
minute=$((10#$(date +%M)))
# bo gdy minuta/godzina była np. 09 to uznawało to za 9 w systemie oktalnym (error: value to great for base)

# hour=$((RANDOM % 24))
# minute=$((RANDOM % 60))
# echo "$hour:$minute"

# jeżeli bez parametrów
if (($# == 0)); then
    dokladna $hour $minute

#jeżeli z parametrami
else
    case $mode in
        -h | --help | --hlep | --chleb) help;;
        -p | --do-pol) do_pol $hour $minute;;
        -g | --do-godziny) do_godziny $hour $minute;;
        -n | --niedokladny) niedokladny $hour $minute;;
        -a | --all) echo -ne "dokładna:\t"; dokladna $hour $minute; echo -ne "do pół godziny:\t";do_pol $hour $minute; echo -ne "do godziny:\t"; do_godziny $hour $minute; echo -ne "niedokładny:\t"; niedokladny $hour $minute;;
    esac
fi