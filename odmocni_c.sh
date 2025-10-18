#!/bin/bash

echo "Zadej cislo k odmocneni: "
read n
vysledek=$(./odmocni $n)

echo "Vysledek: $vysledek"
