#!/bin/bash

if [[ $PWD = /home/lijie/manga* ]]; then
    echo Current dir OK: $PWD
else
    echo Current dir BAD: $PWD
    exit
fi
echo

if [ $# -eq 2 ]; then
	title=$1
	split=$2
elif [ $# -eq 1 ]; then
	title=$1
	read -p "Split? (Y/n) " yn
	case $yn in
		[Yy]* ) split=1;;
		[Nn]* ) split=0;;
		* ) split=1;;
	esac
else
	while [ -z "$title" ]; do
		read -p "Title? " title
	done

	read -p "Split? (Y/n) " yn
	case $yn in
		[Yy]* ) split=1;;
		[Nn]* ) split=0;;
		* ) split=1;;
	esac
fi

if [ $split -eq 1 ]; then
    i=0;
    for f in *; do
        d=V$(printf %02d $((i/50+1)));
        mkdir -p $d;
        mv "$f" $d;
        let i++;
    done
    time python3 ~/kcc/kcc-c2e.py -p KoAO -q -f CBZ -r 1 -c 0 -u -t $title --blackborders -b 2 ./;
else
    time python3 ~/kcc/kcc-c2e.py -p KoAO -q -f CBZ -r 1 -c 0 -u -t $title --blackborders -b 0 ./;
fi
