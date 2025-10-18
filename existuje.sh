#!/bin/bash

echo "Zapiš název souboru:"
read nazev

if test -f $nazev
then
  echo "Soubor existuje."
else
  echo "Soubor neexistuje!"
fi
