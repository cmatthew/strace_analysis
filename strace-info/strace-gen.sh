#! /bin/bash

# Stephen Tredger

fName="-strace.txt" # traces will have this appended to the prog name
stOpts="-v" # options to be passed to strace (other than -o)


# read commands into an array, we ignore any lines with a #
#	and then replace all spaces with # so we can treat
#	the entire command as a single string
kernPrgs=( `cat kernel-test | grep -v \# | tr ' ' '#'` )
#netPrgs=( `cat network-test | grep -v \# | tr ' ' '#'` )


# set up directories and capture a trace in the process
echo "Setting up directories\n"
prog="mkdir"
arg="mkdir traces traces/kernel traces/network  analysis analysis/kernel analysis/network"
echo "generating trace: $arg"
strace $stOpts -o $prog$fName $arg


# generate traces for kernal programs
outdir="traces/kernel/"
echo "Generating kernel traces in $outdir"

for arg in ${kernPrgs[@]}; do
	arg=`echo $arg | tr '#' ' '` # put spaces back
	echo "generating trace: $arg"
	prog=`echo $arg | cut -f1 -d \ ` # get program name
	strace $stOpts -o $outdir$prog$fName $arg > /dev/null # we only want to see stderr messages
done


# generate traces for network programs
outdir="traces/network/"
echo "Generating network traces in $outdir"

for arg in ${netPrgs[@]}; do
	arg=`echo $arg | tr '#' ' '`
	echo "generating trace: $arg"
	prog=`echo $arg | cut -f1 -d \ `
	strace $stOpts -o $outdir$prog$fName $arg > /dev/null
done

