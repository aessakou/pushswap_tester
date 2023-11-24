#!/bin/bash


art="                           | |     | |       "           
art1="  _ __ ___   __ _ _ __   __| | __ _| |_ ___  _ __ _   _ "
art2=" | '_ \` _ \ / _\` | '_ \ / _\` |/ _\` | __/ _ \| '__| | | |"
art3=" | | | | | | (_| | | | | (_| | (_| | || (_) | |  | |_| |"
art4=" |_| |_| |_|\__,_|_| |_|\__,_|\__,_|\__\___/|_|   \__, |"
art5="                                                   __/ |"
art6="                                                  |___/ "


function print_mandatory {

    echo -e "\033[1;$1m$art\033[0m"
    echo -e "\033[1;$1m$art1\033[0m"
    echo -e "\033[1;$1m$art2\033[0m"
    echo -e "\033[1;$1m$art3\033[0m"
    echo -e "\033[1;$1m$art4\033[0m"
    echo -e "\033[1;$1m$art5\033[0m"
    echo -e "\033[1;$1m$art6\033[0m"

}

function print_at_begin {

    clear
    colors=("31" "32" "33" "34" "35" "36")  # Different color codes
    for ((j=0; j < 5; j++))
    do
    for ((i=0; i<${#colors[@]}; i++)); do
        color_code=${colors[i]}
    #   echo -en "\033[${color_code}mFuture is Loading\033[0m'
        print_mandatory "$color_code"
        sleep 0.04  # Sleep for 1 second (adjust as needed)
        clear
    done
    done
    print_mandatory "33"
}

function make_re {
    c++ compiler.cpp -o compiler
    ./compiler
    if [ $? != 0 ]
    then
        echo -e "\n\033[1;31mERROR in compilation, Please fix it\033[0m";
        exit 0;
    fi
}


make_re

sleep 0.1;
# print_at_begin
print_mandatory "33"

