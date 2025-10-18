#!/bin/bash

vzorovy_text="globální proměnná" 

foo()
{
  local vzorovy_text="lokální proměnná" 
  echo "Provádí se funkce foo" 
  echo $vzorovy_text
} 

echo "Začátek skriptu" 
echo $vzorovy_text 

foo

echo "Konec skriptu"
echo $vzorovy_text

exit 0 
