#!/bin/bash


art="                           | |     | |       "           
art1="  _ __ ___   __ _ _ __   __| | __ _| |_ ___  _ __ _   _ "
art2=" | '_ \` _ \ / _\` | '_ \ / _\` |/ _\` | __/ _ \| '__| | | |"
art3=" | | | | | | (_| | | | | (_| | (_| | || (_) | |  | |_| |"
art4=" |_| |_| |_|\__,_|_| |_|\__,_|\__,_|\__\___/|_|   \__, |"
art5="                                                   __/ |"
art6="                                                  |___/ "

norm=""

min=9999
max=0
avg=0
grade=""
f_grade=0

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
    rm -rf compiler
    if [ $? != 0 ]
    then
        echo -e "\n\033[1;31mERROR in compilation, Please fix it\033[0m";
        exit 0;
    fi
}

function test_norm {
    norminette;
    if [ $? != "0" ]
    then
        norm="\033[1;31mKO\033[0m"
    else
        norm="\033[1;32mOK\033[0m"
    fi
}

function test_mandatory {
    file=`echo test_mandatory.txt$2`
    ./../push_swap $1 > "$file"
    res=$(< "$file" ./checker $1)
    if [ "$res" != "OK" ]
    then
        echo -n "ERROR"
    else
        num=$(wc -l < "$file")
        # if [ $3 -lt 100 ]; then
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
        fi
        # elif [ $3 -lt 500 ]; then
        #     if [ "$num" -lt "5500" ];then
        #         grade=5
        #     elif [ "$num" -lt "7000" ];then
        #         grade=4
        #     elif [ "$num" -lt "8500" ];then
        #         grade=3
        #     elif [ "$num" -lt "10000" ];then
        #         grade=2
        #     elif [ "$num" -lt "11500" ];then
        #         grade=1
        #     fi
        # fi
        if [ $num -lt $min ]; then
            min=$num
        fi
        if [ $max -lt $num ]; then
            max=$num
        fi
        avg=$(expr $avg + $num)
        echo -en "\033[1;32m OK | Instructions:\033[0m" $num
        echo " Grade = " $grade
        f_grade=$(expr $grade + $f_grade)
    fi

    rm -rf "$file"
}

function while_test {
    # c++ counter.cpp -o counter
    limit=$2
    for ((i=1; i<=limit; i++)); do
        ARG=`shuf -i 1-10000 -n $1 | awk '!seen[$0]++' | tr "\n" " "`
        echo -en "\033[3;34mTest $i:\033[0m"
        test_mandatory "$ARG" "$i" "$1"
    done
    echo "--------------------------------------------"
    echo -en "\033[1;34m   Final grade = \033[0m"
    echo -en "\033[1;35m"
    echo -en `expr $f_grade / $limit`
    echo -en "\033[0m"
    for ((j=1; j<=($f_grade / $limit);j++)); do
        echo -en " ⭐"
    done
    echo ""
    echo -e "   \033[1;34mStatistics of $1 numbers:"
    echo -e "\033[0m   \033[1;31mMax =\033[0m\033[1;36m" $max
    echo -e "\033[0m   \033[1;33mavg =\033[0m\033[1;36m" `expr $avg / $limit`
    echo -e "\033[0m   \033[1;32mMin =\033[0m\033[1;36m" $min
    echo -e "\033[0m"
}

make_re
test_norm

# echo -en "\033[1;34mNORMINTTE: \033[0m"
# echo -e $norm

# sleep 0.1;
# print_at_begin
print_mandatory "33"

while_test "100" "1"
# test_mandatory "3 2 5 6 9 8 4"
# test_mandatory ""
# test_mandatory "1 3 2"
