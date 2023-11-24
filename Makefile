NAME=tester.sh
HELP=display_help.sh

.PHONY: all M H

.DEFAULT_GOAL := default

all:
	@/bin/bash waiting.sh
	@echo "\033[1;32m\t\tTest is running:\033[0m"
	@/bin/bash $(NAME)

# @c++ waiting.cpp -o waiting
# @./waiting
M:
	@/bin/bash $(NAME)

H:
	@/bin/bash $(HELP)

%:
	@echo "⛔ Please Enter a valid option"
	@echo "See Help below ⏬"
	@/bin/bash $(HELP)

.SILENT:

default:
	@echo "Try make H to see the help page"