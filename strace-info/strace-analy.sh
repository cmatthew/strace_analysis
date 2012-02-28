#! /bin/bash

# Stephen Tredger

traceDir="traces"
resDir="analysis"

countName="-callcount.txt" # syscall counts will be progname with this appended
noteName="-notablecalls.txt" # notable calls from notable-syscalls like this

# read in notable calls from notable-syscalls, lines with # are ignored
#	and newline characters are replaced with spaces
noteCalls=( `cat notable-syscalls | grep -v \# | tr '\n' ' '`)


# generate results for traces in traces/kernel/
for file in $traceDir/kernel/*; do
	outFile="$( echo "$file" | cut -f1 -d \- | cut -f3 -d /)"
	cat $file | cut -f1 -d \( | sort | uniq -c > $resDir/kernel/$outFile$countName
	for call in ${noteCalls[@]}; do
		grep $call $file | sort >> $resDir/kernel/$outFile$noteName
	done
done


# generate results for traces in traces/network/
for file in $traceDir/network/*; do
	outFile="$( echo "$file" | cut -f1 -d \- | cut -f3 -d /)"
	cat $file | cut -f1 -d \( | sort | uniq -c > $resDir/network/$outFile$countName
	for call in ${noteCalls[@]}; do
		grep $call $file | sort >> $resDir/network/$outFile$noteName
	done
done


