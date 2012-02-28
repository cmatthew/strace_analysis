#! /bin/bash

# Stephen Tredger

# Usage: [Options] <prog> <args>
# Options: -td=<dir>, trace output directory
#	   -rd=<dir>, results output directory
#	   -p=<pid>, we are passing in a process id to attach to, not a command 
#			will not perform analysis if killed on the command line
#			as the script terminates as well
#	   -priv, run with sudo (will require password upon prompt)


traceDir=""
resDir=""
prog=""
args=""

traceName="-strace.txt" # traces will have this appended to the prog name
countName="-callcount.txt" # syscall counts will be progname with this appended
noteName="-notablecalls.txt" # notable calls from notable-syscalls like this

traceCall="strace"
stOpts="-v" # options to be passed to strace (other than -o)

# read notable sys calls into an array
noteCalls=( `cat notable-syscalls | grep -v \# | tr '\n' ' '`)


# parse command line options
for arg in $@; do
	param=`echo $arg | cut -f1 -d = `
	case $param in
		-td )
			# get directory name and append with a "/"
			traceDir=`echo $arg | cut -f2 -d = `/
			shift;;
		-rd )
			resDir=`echo $arg | cut -f2 -d = `/
			shift;;
		-p )
			pid=`echo $arg | cut -f2 -d = `
			shift;;
		-priv )
			traceCall="sudo `echo $traceCall`"
			shift;;
	esac
done


if [ $pid ]; then
	args="-p "`echo $pid`
	prog=`ps | grep $pid | cut -f3 -d : | cut -f2 -d \ `"-"$pid
else
	# after parsing $1 will be the program name
	args=$@
	prog=$1
fi

traceFile=$traceDir$prog$traceName


#capture trace
$traceCall $stOpts -o $traceFile $args > /dev/null


#generate results from trace file
cat $traceFile | cut -f1 -d \( | sort | uniq -c > $resDir$prog$countName
for call in ${noteCalls[@]}; do
	grep $call $traceFile | sort >> $resDir$prog$noteName
done

