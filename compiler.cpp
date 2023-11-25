#include <iostream>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <iomanip>
#include <thread>
#include <chrono>
#include <string>

int main()
{
    pid_t pid = fork();
    if (pid == 0)
    {

        if (system("make re -C ../. > compiler_output 2> errors") != 0)
            exit (1);
        if (system("make clean -C ../. > clean_output 2> errors") != 0)
            exit (1);
    }
    else
    {
        int status;
        std::string cmp = "Compiling";
        size_t counter = 0;
        while (waitpid(pid, &status, WNOHANG) == 0)
        {
            std::cerr << "\033[1;32m" << cmp << "\033[0m";
            usleep (300);
            std::cout << '\r' << std::setw(30) << ' ' << '\r' << std::flush;
            if (counter % 1000 == 0)
                cmp += ".";
            if (cmp == "Compiling....")
                cmp = "Compiling";
            counter++;
        }
        system("rm -rf errors");
        system("rm -rf clean_output");
        system("rm -rf compiler_output");
        if ( WEXITSTATUS(status) == 0)
        {
            std::cerr << "\033[1;32mCompilation is done.\033[0m" << std::endl;
        }
        else
        {
            std::cerr << "\033[1;31mERROR is the Compilation.\033[0m" << std::endl;
            system("cat errors");
            exit (1);
        }
    }
}