#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <cpcapng/io.h>

int main(int argc, char **argv)
{

	cpcapng_file_read_debug(argv[1]);

	return 0;
}
