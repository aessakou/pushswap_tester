# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    display_help.sh                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aessakou <aessakou@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/26 11:01:16 by aessakou          #+#    #+#              #
#    Updated: 2023/11/26 11:01:17 by aessakou         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#/bin/bash

echo -ne "\033[2;37m"
echo -e "\033[1;32m"
sed -n 1p help.txt
echo -e -n "\033[1;35m"
sed -n 2p help.txt
echo -e -n "\033[0m"
sed -n 3p help.txt
sed -n 4p help.txt
sed -n 5p help.txt
sed -n 6p help.txt
sed -n 7p help.txt
echo -e "\033[0m"