// hello.cpp - simple hello world example

#include<stdlib.h> // EXIT_SUCCESS
#include<stdio.h> // perror(3)
#include <sys/utsname.h> // uname(2)

#include <iostream> // std::cout, std::endl

int main(int argc, char **argv)
{
	struct utsname u;
	if (uname(&u)){
		perror("uname");
		return EXIT_FAILURE;
	}

	std::cout << "Hello, " << u.machine << " world!" << std:: endl;
	return EXIT_SUCCESS;
}
