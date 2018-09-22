#!/bin/bash

if [[ $PWD = /home/lijie/SharedFolder* ]];
then
    echo Current dir OK: $PWD
else
    echo Current dir BAD: $PWD
    exit
fi
echo

append_suffix=1
split=1

read -p "Add jpg suffix? (Y/n) " yn
case $yn in
    [Yy]* ) append_suffix=1;;
    [Nn]* ) append_suffix=0;;
    * ) append_suffix=1;;
esac

read -p "Split? (Y/n) " yn
case $yn in
    [Yy]* ) split=1;;
    [Nn]* ) split=0;;
    * ) split=1;;
esac

if [ $append_suffix -eq 1 ];
then
    echo "Appending jpg suffix..."
    time find . -type f -exec mv '{}' '{}'.jpg \;;
fi

if [ $split -eq 1 ];
then
    i=0;
    for f in *;
    do
        d=V$(printf %02d $((i/50+1)));
        mkdir -p $d;
        mv "$f" $d;
        let i++;
    done
    time python3 ~/kcc/kcc-c2e.py -p KoAO -q -f CBZ -r 1 -c 0 -u --blackborders -b 2 ./;
else
    time python3 ~/kcc/kcc-c2e.py -p KoAO -q -f CBZ -r 1 -c 0 -u --blackborders -b 0 ./;
fi
