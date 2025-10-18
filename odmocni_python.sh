#!/bin/bash

echo "Zadej cislo k odmocneni: "
read n
vysledek=$(python3 odmocni.py $n)
echo "Vysledek: $vysledek"
