# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aessakou <aessakou@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/26 11:00:40 by aessakou          #+#    #+#              #
#    Updated: 2023/11/29 22:17:19 by aessakou         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash


art="                           | |     | |       "           
art1="  _ __ ___   __ _ _ __   __| | __ _| |_ ___  _ __ _   _ "
art2=" | '_ \` _ \ / _\` | '_ \ / _\` |/ _\` | __/ _ \| '__| | | |"
art3=" | | | | | | (_| | | | | (_| | (_| | || (_) | |  | |_| |"
art4=" |_| |_| |_|\__,_|_| |_|\__,_|\__,_|\__\___/|_|   \__, |"
art5="                                                   __/ |"
art6="                                                  |___/ "

progname="push_swap"

norm=""

grade=""

SYST=""

checker=""

min_M=99999999
max_M=0
avg_M=0
f_grade_M=5

min_A=99999999
max_A=0
avg_A=0
f_grade_A=5

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
        echo -e "\n\033[1;31mERROR in Compilation, Please fix it\033[0m";
        rm -rf compiler
        exit 1;
    fi
    rm -rf compiler
    progname=$(grep "^NAME" ../Makefile | tr "=" " " | awk '{ print $2}')
}

function test_norm {
    norminette ../. > errors 2> errors;
    if [ $? != "0" ]
    then
        norm="\033[1;31mKO\033[0m"
    else
        norm="\033[1;32mOK\033[0m"
    fi
    rm -rf errors;
}

function test_mandatory1 {
    file="test_mandatory.txt$2"
    ./../$progname $1 > "$file"
    res=$(< "$file" ./$checker $1)
    if [ "$res" != "OK" ]
    then
        echo -n "ERROR"
    else
        num=$(wc -l < "$file")
        if [ "$num" -lt "700" ];then
            grade=5
        elif [ "$num" -lt "900" ];then
            grade=4
        elif [ "$num" -lt "1100" ];then
            grade=3
        elif [ "$num" -lt "1300" ];then
            grade=2
        elif [ "$num" -lt "1500" ];then
            grade=1
        else
            grade=0
        fi
        if [ $num -lt $min_M ]; then
            min_M=$num
        fi
        if [ $max_M -lt $num ]; then
            max_M=$num
        fi
        avg_M=$(expr $avg_M + $num)
        count=$(expr length "$2")
        count=$(expr 7 - $count)
        spaces=$(printf "%-${count}s" " ")
        echo -en "\033[1;32m${spaces}OK \033[0m|\033[2;36m Instructions:\033[0m" $num
        echo -e "\033[0;36m Grade = \033[0m" $grade
        if [ $grade -lt $f_grade_M ]
        then
            f_grade_M=$grade
        fi
    fi

    rm -rf "$file"
}

function test_mandatory2 {
    file="test_mandatory.txt$2"
    ./../$progname $1 > "$file"
    res=$(< "$file" ./$checker $1)
    if [ "$res" != "OK" ]
    then
        echo -n "ERROR"
    else
        num=$(wc -l < "$file")
        if [ "$num" -lt "5500" ];then
            grade=5
        elif [ "$num" -lt "7000" ];then
            grade=4
        elif [ "$num" -lt "8500" ];then
            grade=3
        elif [ "$num" -lt "10000" ];then
            grade=2
        elif [ "$num" -lt "11500" ];then
            grade=1
        else
            grade=0
        fi
        if [ $num -lt $min_A ]; then
            min_A=$num
        fi
        if [ $max_A -lt $num ]; then
            max_A=$num
        fi
        avg_A=$(expr $avg_A + $num)
        count=$(expr length "$2")
        count=$(expr 7 - $count)
        spaces=$(printf "%-${count}s" " ")
        echo -en "\033[1;32m${spaces}OK \033[0m|\033[2;36m Instructions:\033[0m" $num
        echo -e "\033[0;36m Grade = \033[0m" $grade
        if [ $grade -lt $f_grade_A ]
        then
            f_grade_A=$grade
        fi
    fi

    rm -rf "$file"
}

function while_test {
    # c++ counter.cpp -o counter
    echo "------------------------------------------------"
    limit=$2
    for ((i=1; i<=limit; i++)); do
        if [ "$SYST" == "Linux" ]; then
            ARG=`shuf -i 1-10000 -n $1 | awk '!seen[$0]++' | tr "\n" " "`
        elif [ "$SYST" == "MACOS" ]; then
            ARG=$(jot -r $1 1 10000 | awk '!seen[$0]++' | tr "\n" " ")
        fi
        echo -en "\033[3;34mTest $i:\033[0m"
        if [ $1 -lt 101 ]
        then
            test_mandatory1 "$ARG" "$i" "$1"
        else
            test_mandatory2 "$ARG" "$i" "$1"
        fi
    done
}

function print_statis {
    echo -e "\033[1;34mStatistics of $1 numbers:"
    echo -e "\033[0m   \033[1;31mMax =\033[0m\033[1;36m" $3
    echo -e "\033[0m   \033[1;33mavg =\033[0m\033[1;36m" $4
    echo -e "\033[0m   \033[1;32mMin =\033[0m\033[1;36m" $5
    echo -en "\033[0m\033[1;34m   Final grade = \033[0m"
    echo -en "\033[1;35m"
    echo -en $2
    echo -en "\033[0m"
    lim=$2
    for ((j=1; j<=lim;j++)); do
        echo -en " ⭐"
    done
    echo ""
    echo ""
}

# print_at_begin
make_re

test_norm

# sleep 0.1;
# print_mandatory "33"

def_num=50

if [ "$(uname -s)" == "Darwin" ]; then
    SYST="MACOS"
    checker="checker_Mac"
elif [ "$(uname -s)" == "Linux" ]; then
    SYST="Linux"
    checker="checker"
else
    echo "Unknown operating system, Pleas use macOS or Linux."
    exit 1;
fi

if [ -z "$N" ]
then
    NUMS=$def_num
else
    NUMS=$N
fi

if [ -z "$R" ]
then
    AV="YES"
    MV="YES"
    echo "Middle  Version  test [100]:"
    while_test "100" "$NUMS"
    # NUMS=20
    echo "Advanced Version test [500]:"
    while_test "500" "$NUMS"
    echo "------------------------------------------------"
    print_statis "100" $f_grade_M $max_M "$(expr $avg_M / $def_num)" $min_M
    print_statis "500" $f_grade_A $max_A "$(expr $avg_A / $NUMS)" $min_A
elif [ $R -lt 101 ]; then
    RANG=$R
    echo "Middle  Version  test [$RANG]:"
    while_test "$RANG" "$NUMS"
    echo "------------------------------------------------"
    print_statis "$RANG" $f_grade_M $max_M "$(expr $avg_M / $NUMS)" $min_M
elif [ $R -lt 501 ]; then
    RANG=$R
    echo "Advanced Version test [$RANG]:"
    while_test "$RANG" "$NUMS"
    echo "------------------------------------------------"
    print_statis "$RANG" $f_grade_A $max_A "$(expr $avg_A / $NUMS)" $min_A
elif [ $R -gt 500 ]; then
    echo "the range of numbers is greater than 500"
fi



echo -en "\033[1;34mNORMINETTE: \033[0m"
echo -e $norm