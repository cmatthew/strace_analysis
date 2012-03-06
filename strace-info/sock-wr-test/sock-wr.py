# sock-wr.py
#
# Stephen Tredger
#
# Intended to be called from bash script sock-wr.sh
#
# Takes strace info as arguments to stdin (lines with no whitespace)
#	Will look for file descriptors returned by socket
#	and print the relevant lines. Used to look for sockets that
#	have read/write called on them instead of send/recv
#

import sys

try:
    file = open(sys.argv[1], "r")
except IOError:
	print >> sys.stderr, "failed to open file " + sys.argv[1]
	sys.exit(-1)
	
sockfds = dict()

for line in file:

	# if line starts with socket
	if line.find("socket") == 0:
		
		# get fd returned by socket
		fd = line.split("=")[1].strip()
		
		# place the fd in dictionary if it doesnt exits (it shouldn't)
		if fd not in sockfds:
			sockfds[fd] = line		
		else:
			print >> sys.stderr, "file descriptor " + fd \
					+ " exists in dictionary as " + sockfds[fd]
		
	# if line starts with read or write
	elif line.find("read") == 0 or line.find("write") == 0:
		
		# get fd read or written to
		fd = line.split(",")[0].split("(")[1].strip()
		
		# if the fd is in sockfds print the line with the socket call
		#	(if we have not seen it before) and the read/write line
		if fd in sockfds:
			if len(sockfds[fd]) != 0:
				print sockfds[fd],
				sockfds[fd] = ""
			print line,
		
	# if line starts with close
	elif line.find("close") == 0:
		
		# get fd closed
		fd = line.split(")")[0].split("(")[1].strip()
		
		# if the fd is in sockfds remove it
		if fd in sockfds:
			# if it is empty print the close line
			if len(sockfds.pop(fd)) == 0:
				print line,
			
