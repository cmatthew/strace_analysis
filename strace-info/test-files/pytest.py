# simple python test for strace

fname= "test-files/scratch.txt"
try:
	f = open(fname, "r+")

	for line in f:
		print line
	f.write("python'ed!\n")

	f.close()

except IOError as (errno, strerror):
	print "I/O error({0}): {1}".format(errno, strerror)
