#! /bin/bash

# Stephen Tredger

fName="-strace.txt"
stOpts="-v"


kernPrgs=( `cat kernel-test | grep -v \# | tr ' ' '#'` )
netPrgs=( `cat network-test | grep -v \# | tr ' ' '#'` )


# set up directories and capture a trace in the process
echo "Setting up directories\n"
prog="mkdir"
arg="mkdir traces traces/kernel traces/network  analysis analysis/kernel analysis/network"
echo "generating trace: $arg"
strace $stOpts -o $prog$fName $arg


# generate traces for kernal programs
outdir="traces/kernel/"
echo "\nGenerating kernel traces in $outdir"

for arg in ${kernPrgs[@]}; do
	arg=`echo $arg | tr '#' ' '`
	echo "generating trace: $arg"
	prog=`echo $arg | cut -f1 -d \ `
	strace $stOpts -o $outdir$prog$fName $arg > /dev/null
done


# generate traces for network programs
outdir="traces/network/"
echo "\nGenerating kernel traces in $outdir"

for arg in ${netPrgs[@]}; do
	arg=`echo $arg | tr '#' ' '`
	echo "generating trace: $arg"
	prog=`echo $arg | cut -f1 -d \ `
	strace $stOpts -o $outdir$prog$fName $arg > /dev/null
done

