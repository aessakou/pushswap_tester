#include <iostream>
#include <string>


int main()
{
    std::string line;
    std::cerr << "\e[1;34mDo you want to test mandatory part and bonus part.\e[0m\e[31m[Y/N][ENTER==YES]\e[0m" << std::endl;
    std::getline(std::cin, line);
    if (line.empty() || line  == "Y" || line == "y" || line == "yes" || line == "Yes" || line == "YES")
        return 0;
    else
        exit(1);
}