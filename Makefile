# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aessakou <aessakou@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/26 11:00:45 by aessakou          #+#    #+#              #
#    Updated: 2023/11/26 20:09:13 by aessakou         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME=./tester.sh
HELP=display_help.sh
BONUS=test_bonus.sh

.PHONY: A M B H

.DEFAULT_GOAL := default

A:
	@/bin/bash waiting.sh
	@/bin/bash $(NAME) $(R) $(N)

M:
	@/bin/bash $(NAME) $(R) $(N)

H:
	@/bin/bash $(HELP)

B:
	@/bin/bash $(test_bonus)

%:
	@echo "⛔ Please Enter a valid option"
	@echo "⏬ See 'Help' below ⏬"
	@/bin/bash $(HELP)

.SILENT:

default:
	@echo "PS_Tester: missing operand after 'make'"
	@echo "PS_Tester: Try 'make H' for more information."