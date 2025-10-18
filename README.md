

# L11: Bash skripty -- echo, proměnné 


> <code>[linux.edumach.cz](https://linux.edumach.cz/)</code>


---


## Skripty v jazyce Bash

Skripty v jazyce Bash mají několik hlavních významů a použití:

1. **Automatizace úloh**: Bash skripty umožňují automatizovat opakující se úkoly a procesy v operačním systému Linux a Unix. Mohou být použity k vytvoření scénářů, které provádějí sekvenci příkazů nebo akcí, čímž snižují potřebu manuálního zásahu.

2. **Správa systému**: Skripty Bash jsou často využívány pro správu a monitorování systému. Administrátoři mohou psát skripty pro zálohování dat, správu uživatelů, sledování výkonu a další úkoly, které usnadňují správu serverů a počítačových systémů.

3. **Zpracování textových dat**: Bash skripty umožňují rychlé a flexibilní zpracování textových souborů. Můžete je použít k filtrování, analýze a transformaci textových dat, což je užitečné pro logickou analýzu a manipulaci s různými formáty dat.

4. **Automatizace úloh vývoje**: Vývojáři mohou používat Bash skripty pro automatizaci úkolů spojených s vývojem softwaru. To zahrnuje sestavení, testování, nasazování a správu aplikací, což může zvýšit produktivitu a zjednodušit workflow vývojového týmu.

5. **Interakce s operačním systémem**: Bash skripty mohou provádět různé operace v operačním systému, včetně vytváření, mazání a přesunování souborů, změny oprávnění, spouštění procesů a dalších systémových úkonů.


Celkově řečeno, Bash skripty mají široké využití v administrativě, vývoji a automatizaci úloh v prostředí Linuxu a Unixu a umožňují uživatelům efektivněji a konzistentněji manipulovat s operačním systémem a daty.

 
## Co je to ten `bash`


`Bash` (**B**ourne **A**gain **Sh**ell) je standardní interpret příkazů v Linuxu založený na Bourne shell. Funguje jako rozhraní mezi uživatelem a systémem.

Jde používat i v interaktivním režimu. Pokud máte před sebou otevřený terminál, pak ho právě v tomto režimu používáte. 

To je standardní postup, který čeká na zadání příkazu od uživatele. Příkazy mohou být buď přímo zabudované v shellu nebo samostatné programy napsané téměř v libovolném programovacím jazyku.

Pomocí systémových proměnných umožňuje přizpůsobení pracovního prostředí. Některé z těchto proměnných jsou přednastaveny systémem, ostatní nastavuje uživatel např. v inicializačních souborech při spuštění shellu.

`Bash` je také velice mocný programovací nástroj. Když nám chybí nějaký program, nemusíme ho hned psát v jazyce C nebo Python, ale je možné vyřešit ho vytvořením skriptu.

Kromě bash existuje řada dalších: `sh`, `csh`, `ash`, `ksh`, `tcsh`, na macOS je to `zsh`. 

Zjistěte, jestli máte jako implicitní shell nastaven opravdu `bash`:

```bash
$ echo $SHELL
/bin/bash
```

Příkaz `echo $SHELL` vypíše vámi používaný shell. `$SHELL` je interní proměnná shellu - musí být velkými písmeny. Jak vidíte, i `bash` je spustitelný program, který je uložen v `/bin`.




## Příkaz `echo`

```
echo [prepinace] [argument]
```

Příkaz `echo` vypíše argument:

```bash
$ echo Ahoj světe
Ahoj světe

$ echo "Ahoj světe"
Ahoj světe

$ echo "Ahoj\nsvěte"
Ahoj\nsvěte

$ echo -e "Ahoj\nsvěte"
Ahoj
světe
```

Přepínač `-e` vyhodnocuje escapovací znaky jako příkazy, jinak je `\n` vyhodnocen jako obyčejný text. Přepínač `-n` potlačí odřádkování. Více na `man echo`.

## Příkaz `read`

```
read <nazev>
```

Načte hodnotu a uloží do proměnné (nějaký textový řetězec). Proměnné vzniknou až přiřazením. **Všechny jsou řetězec. Desetinná čísla bash nezná.**

```bash
$ read x
25

$ read y
linux
```

Vznikly proměnné: `x` s hodnotou `25` a `y` s hodnotou `linux`.


## Proměnné

Výpis obsahu proměnných

```bash
$ echo "x"
x

$ echo "x y" 
x y
```

Při použití se proměnná uvozuje znakem `$`. Tím se odliší od běžného textu:

```bash
$ echo "Hodnota x je $x"
Hodnota x je 25

$ echo "$x $y"
25 linux

$ echo $x$y
25linux
```

## Výrazy

```bash
$ echo "wc -l /etc/apt/sources.list"
wc -l /etc/apt/sources.list
```

```bash
$ echo $(wc -l /etc/apt/sources.list)
20 /etc/apt/sources.list
```

V prvním příkladu se jen vypíše argument na standardní výstup.

Ve druhém příkladu se nejprve vykoná příkaz v `$()` a jeho výstup předá příkazu `echo`, který jej vypíše na standardní výstup. 


Trochu „sofistikovanější“ konstrukce:

```bash
$ cesta=/etc/apt/sources.list

$ echo $(wc -l $cesta)
20 /etc/apt/sources.list
```

```bash
$ echo $(wc -l $cesta) | awk {'print $1'}
20
```

V prvním příkladu se na prvním řádku do proměnné `cesta` uloží řetězec s požadovaným souborem (včetně cesty). Ve druhém řádku se obsah proměnné `$cesta` použije jako argument příkazu `wc`.

Ve druhém příkladu se výstup nejprve pošle rourou příkazu `awk`, který z řetězce

```bash
20 /etc/apt/sources.list
```

vypíše první „sloupec“ `$1`.


## Aritmetické operace

Bash podporuje pouze základní čtveřici operací `+`, `-`, `*`, `/` (pouze celočíselné), dále `%` (modulo) a závorky `( )`. Samozřejmě se respektuje priorita operací.

Důvod je prostý: skripty v bashi jsou primárně cílené na zpracování souborů, nikoliv pro provádění výpočtů. Bash například neumí pracovat s desetinnými čísly. K výpočtům slouží je Python, C nebo neinteraktivní kalkulačka `bc`.


```bash
$ echo $x + $y
25 + 10

$ echo $($x + $y)
-bash: 25: command not found

$ echo $(($x + $y))
35

$ echo $(($x % $y))
5
```

Aby se výraz `$x + $y` vyhodnotil, je potřeba jej „**zapouzdřit**“ do `( )`. Vypadá to nelogicky, ale není. Výraz `($x + $y)` bash vypočte. Výsledkem je číslo `35`. Tu bash vnímá jako „interní proměnnou“ a ta se vypisuje konstrukcí `$()`.


### Neinteraktivní kalkulačka `bc`

Pokud byste ve svých skriptech potřebovali nějaké složitější výpočty, lze využít program `bc`, což je neinteraktivní kalkulačka.

```bash
echo "2^128" | bc
$ echo "10/3" | bc
$ echo "scale=4;10/3" | bc
```

kde `scale` definuje počet desetinných míst, středník je oddělovač příkazů.

Program `bc` umí i mnohem složitější výpočty. Základy zjistíte tradičně v manuálové stránce [https://man7.org/linux/man-pages/man1/bc.1p.html](https://man7.org/linux/man-pages/man1/bc.1p.html) nebo na jiných webech [https://duckduckgo.com/?q=linux+bc+examples](https://duckduckgo.com/?q=linux+bc+examples). 

### Kooperace skriptu a programu

Pro složitější matematické, či jakékoliv jiné úlohy je také možné využít jazyků **Python** nebo **C** běžně dostupných ve všech distribucích. v případě C bude možná potřeba doinstalovat překladač `gcc`. 



#### Bash + Python
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

#### Bash + C
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


## Příkaz `date`

```bash
date [prepinace] [+format]
```

Vypíše systémový datum a čas.

```bash
$ date
Mon 07 Apr 2015 12:10:30 PM CET
```

Příkaz má mnoho voleb ve tvaru `%znak`, prostudujte na `man date`.

```bash
$ date "+%Y-%m-%d"
2015-04-07

$ date "+DATE: %F%nTIME: %H:%M:%S"
DATE: 2023-03-04
TIME: 14:03:37
```

🕑 `date` slouží i nastavení času (smí pouze root).


## `echo` a přesměrování

Příkaz `echo` svůj výstup směruje výhradně na standardní výstup (monitor). V skriptech často potřebujeme jej přesměrovat do souboru.

```bash
$ cesta=/etc/apt/sources.list
$ wc -l $cesta > wc1
$ wc -l $cesta | awk {'print $1'} > wc2
$ echo $(wc -l $cesta) | awk {'print $1'} > wc3
```

Všechny tři příklady vykonají totéž: přesměrují svůj výstup do souboru. Pokud soubor neexistuje, vytvoří ho. Pokud existuje, přepíše ho (*overwrite*). Pro přidání na konec souboru slouží konstrukce `>>` (*append*).

```bash
$ cesta=/etc/apt/sources.list
$ wc -l $cesta > wc4
$ wc -l $cesta | awk {'print $1'} >> wc4
$ echo $(wc -l $cesta) | awk {'print $1'} >> wc4
```

## Příkaz `clear`

Příkaz smaže terminál.

```bash
$ clear
```

Poznámka: Ruční smazání je snazší zkratkou <kbd>Ctrl</kbd>+<kbd>L</kbd>.


## Soubor se skriptem

Soubor se skriptem je běžný textový soubor, jehož obsahem jsou řádky s příkazy co má vykonat (program). První řádek souboru uvozuje, v jakém shellu se má spustit:

```bash
#!/bin/bash
```


### Tvorba a spuštění skriptu

Vytvořte soubor `prvni` s tímto kódem. Obsah skriptu si zkopírujte do schránky a přes pravé tlačítko myši do něj vložte. 

```bash
#!/bin/bash
clear
mkdir ~/skripty 2> /dev/null
cd ~/skripty
echo -n "Zapiš svoje jméno: "
read jmeno
echo -e "$jmeno, vítej.\nTvůj home adresář je: $HOME"
echo "Nyní jsi v adresáři: $(pwd)"
echo "Skript skončí za 3 sekundy... "sleep 3
```

Soubor uložte a spusťte příkazem:

```bash
$ bash info
``` se skriptem

Může se stát, že skript bude hlásit něco jako:

```
... $'\r': command not found
```

Je to tím, že skript v linuxu je citlivý na „domácí“ typ konců řádků – musí být `\n` (LF). Windows ukončují řádky `\r\n` (CR+LF), macOS pouze `\r` (CR).

Oprava: otevřete skript v editoru `nano`, uložte pomocí <kbd>Ctrl</kbd>+<kbd>O</kbd> a překódujte jej zkratkou <kbd>Alt</kbd>+<kbd>D</kbd> (popř. <kbd>Alt</kbd>+<kbd>M</kbd>), tak, aby před názvem souboru nic nebylo:

<img src="https://www.edumach.cz/img/nano-kodovani1.png" width="600"><br>✅ Správně: před názvem nic není


<img src="https://www.edumach.cz/img/nano-kodovani2.png" width="600"><br>❌ Nesprávně: před názvem je [DOS Format], popř. [Mac Format]


Další možnost je odstranit znak CR (`\r`) a ponechat LF (`\nm ):

``h
$at skript_crlf.sh | tr -d $'\r' > skript_lf.sh
```
`-d` odstraňuje znak `\r`, který jena nci řádku `$`.


### Oprávnění spouštění

Skripty se dají spouštět příkazem `bash <soubor>`, ale častější je přímo, a to přidáním oprávnění spouštění (*execute*):

```bash
$ chmod +x <nazev>
$ ./<nazev>
```

Příkazem `chmod -x <nazev>` jde zase odebrat. Vyzkoušejte si to. Vždy si oprávnění vypište:

```bash
$ ls -l <nazev>
```

### Přípona názvu souboru se skriptem

Jméno souboru nemá v unixových systémech strukturu a jádro operačního systému přípony nijak nevyužívá. Proto jsou přípony pouze věcí dohody, případně slouží pro uživatele jako vodítko, co je v daném souboru obsaženo.

Soubor se skriptem má dle zvyklostí příponu `.sh`. Budeme to respektovat i my. Proto skript přejmenujte:

```bash
$ mv <nazev> <nazev>.sh
```

## 💾 Cvičení


### 1. `login.sh` 

Vytvořte skript `login.sh` který vypíše, kolik dalších uživatelů je přihlášených (tedy kromě vás). Příkazy, které se budou hodit: `w` ev. `who`, `wc`, roura.

### 2. `trida.sh` 

Vytvořte skript `trida.sh`, který zapíše do nového souboruz e uživatelů jedné třídy oddělených __tabulátory__. Třídu zadá uživatel ve tvaru 17C nebo 17c. Tento text bude zároveň i názvem nového souboru. Příkazy, které se budou hodit: `cat`, `ls`, `grep`, `tr`, roura.


### 3.  `logy.sh`  

Stáhněte si pracovní soubory do svého home adresáře a rozbalte:

```
$ wget https://www.edumach.cz/linux/files/data.tar.gz 
$ tar xvfz data.tar.gz 
$ cd data 
```
Vytvořte skript `logy.sh`, který vyhledá všechny soubory v adresáři `~/data`, jejichž název končí na `.log`, a spočítá celkový počet řádků ve všech těchto souborech dohromady. Na závěr vypíše průměrný počet řádků na jeden `.log` soubor.  Příkazy, které se budou hodit: `ls`, `grep`, `wc`, `awk`, roura.

### 4.  `analyza.sh`  

Vytvořte skript `analyza.sh`, který přečte obsah textového souboru (název souboru zadá uživatel) a vypíše seznam všech unikátních slov, která se v souboru vyskytují, seřazený abecedně. Skript by měl také spočítat celkový počet unikátních slov.  Příkazy, které se budou hodit: `cat`, `tr`, `sort`, `uniq`, `wc`, roura.

### 5.  `statistika.sh`  

Stáhněte si pracovní soubory do svého home adresáře a rozbalte:

```
$ wget https://www.edumach.cz/linux/files/data.tar.gz 
$ tar xvfz data.tar.gz 
$ cd data 
```

Vytvořte skript `statistika.sh`, který vypíše základní statistiku o souborech v adresáři `~/data`. Skript by měl zjistit a vypsat počet souborů, celkovou velikost všech souborů v bajtech, a seznam 5 největších souborů včetně jejich velikostí. Příkazy, které se budou hodit: `ls`, `wc`, `du`, `sort`, `head`, roura.


### 6.  `vyhledat.sh`  

Vytvořte skript `vyhledat.sh`, který vyhledá všechny soubory v aktuálním adresáři a jeho podadresářích, které obsahují dané klíčové slovo. Klíčové slovo zadá uživatel. Skript vypíše seznam nalezených souborů a počet jejich výskytů klíčového slova. Příkazy, které se budou hodit: `grep`, `find`, `wc`, roura.
    




    

