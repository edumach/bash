#!/bin/bash

yes_or_no()
{
  echo "Je tvé jméno $* ?"
  while true
  do
    echo -n "Napiš ano nebo ne: "
    read x
    case "$x" in
      a | ano ) return 0;;
      n | ne ) return 1;;
      * ) echo "Napiš ano nebo ne"
    esac
  done
}

echo "Původní parametr je $*"

if yes_or_no "$1"
then
  echo "Ahoj $1, pěkné jméno"
else
  echo "Nikdy"
fi

exit 0
