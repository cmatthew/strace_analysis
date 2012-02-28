# hist.py

import sys
import cairo
import CairoPlot


files = sys.argv
files.remove(sys.argv[0])

for f in files:
	try:
		inFile=open(f, "r")

		dat={}

		for line in inFile:
			line = line.split()
			try:
				dat[line[1]] = int(line[0])
			except ValueError as (errno, strerror):
				print "Value error({0}): {1}".format(errno, strerror)

		inFile.close()

		f = f.split(".txt")[0].split("-")[-2].split("/")[-1] + "-piechart"
		CairoPlot.pie_plot(f, dat, 1000, 700)

	except IOError as (errno, strerror):
		print "I/O error({0}): " + f + " {1}".format(errno, strerror)
	
