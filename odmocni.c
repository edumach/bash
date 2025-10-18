#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char * argv[])
{
	float cislo = atof(argv[1]); /* nacte cislo a prevede na float */ 
	cislo = sqrt(cislo);
	printf("%f", cislo);
	
	return 0;
}
