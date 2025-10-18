
# Kooperace skriptu a programu

Pro složitější matematické, či jakékoliv jiné úlohy je také možné využít jazyků **Python** nebo **C** běžně dostupných ve všech distribucích. v případě C bude možná potřeba doinstalovat překladač `gcc`. 



## Bash + Python
Níže je jednoduchý příklad skriptu v bashi `odmocni_python.sh`, který spustí program v Pythonu `odmocni.py`. Ten převezme číslo, provede jeho odmocnění a vrátí výsledek zpět do skriptu. 

Bash skript `odmocni_python.sh`:

```bash
#!/bin/bash
echo "Zadej cislo k odmocneni: "
read n
vysledek=$(python3 odmocni.py $n)
echo "Vysledek: $vysledek"
```

Program v Pythonu `odmocni.py`:
```python
import sys
import math

n = float(sys.argv[1]) # převzatý argument
vysledek = math.sqrt(n)
print(vysledek)
```

## Bash + C
Níže je jednoduchý příklad skriptu v bashi `odmocni_c.sh`, který spustí program v C `odmocni`. Ten převezme číslo, provede jeho odmocnění a vrátí výsledek zpět do skriptu. 


Bash skript `odmocni_c.sh`:

```bash
#!/bin/bash

echo "Zadej cislo k odmocneni: "
read n
vysledek=$(./odmocni $n)

echo "Vysledek: $vysledek"
```

Program v C `odmocni.c`:

```c
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
```
Program v C se na rozdíl od skriptů v bashi a Pythonu musí před spuštěním nejprve **zkompilovat** (přeložit do strojového kódu):

```
$ gcc odmocni.c -o odmocni -lm
$ ./odmocni 144
```



☝ Tento model spolupráce skriptů a jazyků vám otevírá doslova **neomezené možnosti** při práci v systému nebo zpracování jakékoliv úlohy! Je to jeden z hlavních důvodů oblíbenosti Linuxu :)

