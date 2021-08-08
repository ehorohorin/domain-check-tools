#!/bin/bash



if [ $# -ne 1 ]; then 
	echo "Error: illegal number of parameters, use $0 <domain> instead"
	exit 1
fi

DEBUG_FILE="debug.txt"

domain=$1

echo "Processing domain: $domain" >> $DEBUG_FILE

#IFS=
dig_out=`dig +short $domain MX 2>/dev/null`
status=$?
echo "Exit code: $status" >> $DEBUG_FILE
if [ ! $status -eq 0 ]; then
	echo $domain
	echo "Dig error code is not zero" >> $DEBUG_FILE	
        echo "FAILED!" >> $DEBUG_FILE
	exit
fi



echo "Output result: $dig_out" >> $DEBUG_FILE
dig_out=`echo $dig_out |  grep '^[0-9]*' | head -n1`
echo "Reduced output result: $dig_out" >> $DEBUG_FILE

if [ -z "$dig_out" ]; then
    echo "FAILED!" >> $DEBUG_FILE
    echo $domain
fi
