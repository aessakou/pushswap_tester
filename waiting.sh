# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    waiting.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aessakou <aessakou@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/26 11:01:55 by aessakou          #+#    #+#              #
#    Updated: 2023/11/26 11:01:56 by aessakou         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#/bin/bash

echo -e "\033[1;34mDo you want to test mandatory part and bonus part.\033[0m\033[31m[Y/N][ENTER==YES]\033[0m"

read input

if [ "$input" != "Y" ] && [ "$input" != "y" ]
then
    if [ -z "$input" ]
    then
        echo -n "";
    else
        echo "See help by typing make h"
        exit 1;
    fi
fi
