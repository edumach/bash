#!/bin/bash

for f in /etc/passwd /etc/group
do
  echo "Soubor $f ma $(wc -l $f | awk '{print $1}') radku."
done
