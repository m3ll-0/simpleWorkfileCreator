#!/bin/bash

FILE=$1;

if [ $1 = "-h" ]; then
	echo -e "Usage: genworkfile <nmap_output> > Workfile";
	exit 1;
fi

if [ ! -f "$FILE" ]
then
	echo -e "File $FILE does not exist! \n\nUsage: genworkfile <nmap_output> > Workfile";
	exit 1;
fi


tcp_ports_open=$(cat $FILE | grep "open" | cut -d "/" -f 1)
tcp_ports_filtered=$(cat $FILE | grep "filtered" | cut -d "/" -f 1);

arr=(`echo ${tcp_ports_open}`);

lines=$(for i in {1..80}; do echo -e -n "-"; done);
islines=$(for i in {1..100}; do echo -e -n "="; done);

modulestring="";
modulestring="OS information: \n\n";



for i in $tcp_ports_open; do
	modulestring="${modulestring}\n\n\n\n\n\n";
        modulestring="${modulestring}$islines \n\n";
        modulestring="${modulestring}Port: $i [Open] \n";
        modulestring="${modulestring}Service: \n\n";
        modulestring="${modulestring}Enumeration: \n\n";
        modulestring="${modulestring}$lines \n\n";
        modulestring="${modulestring}Service versions: \n\n";
        modulestring="${modulestring}$lines \n\n"
        modulestring="${modulestring}Exploits: ";
done;

modulestring="${modulestring}\n\n\n\n";
modulestring="${modulestring}$islines";
modulestring="${modulestring}\n\n\n\n\nFILTERED ports:"

for i in $tcp_ports_filtered; do
        modulestring="${modulestring}\n\n\n\n\n\n";
        modulestring="${modulestring}$islines \n\n";
        modulestring="${modulestring}Port: $i [Filtered] \n";
        modulestring="${modulestring}Service: \n\n";
        modulestring="${modulestring}Enumeration: \n\n";
        modulestring="${modulestring}$lines \n\n";
        modulestring="${modulestring}Service versions: \n\n";
        modulestring="${modulestring}$lines \n\n"
        modulestring="${modulestring}Exploits: ";
done;

echo -e $modulestring;
