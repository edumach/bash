#!/bin/bash

echo -n "Zadej celé číslo: "
read a

if [ $a -gt 100 ]
then
  echo "$a je větší než 100"
elif [ $a -lt 100 ]
then
  echo "$a je menší než 100"
else
  echo "$a je rovno 100"
fi
