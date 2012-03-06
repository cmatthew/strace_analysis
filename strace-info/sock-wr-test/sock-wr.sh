# /bin/bash

##
# Stephen Tredger
#
# sock-wr.sh
#	examines trace files for sockets that have been
#	read/written to instead of send/recv
#

# path to trace files
trace_path="../rpt-files/trace"

# file to output results to
outfile="sock-wr-resuts.txt"

for file in $trace_path/*; do
	echo `echo $file | cut -f4 -d /` >> $outfile
	python sock-wr.py $file >> $outfile	
	# output a blank line
	echo "" >> $outfile
done