#!/usr/bin/env python

#from itertools import groupby
#from operator import itemgetter
import sys

sitecount = {}
for line in sys.stdin:
    # Strip out extra whitespace
    line = line.strip()
    # Extract response bytes from mapper function 
    site, bytes = line.split('\t')
    try:
        bytes = int(bytes)
        sitecount[site] = sitecount.get(site, 0) + bytes
    # If byte count is not a number, then pass over this line
    except ValueError:
        pass

for site, bytes in sitecount.iteritems():
    print '%s' % (bytes)
