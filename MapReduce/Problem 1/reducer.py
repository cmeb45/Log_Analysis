#!/usr/bin/env python

from itertools import groupby
from operator import itemgetter
import sys

def read_map_output(filename):
    for line in filename:
        # Strip out extra whitespace
        line = line.strip()
        # Extract HTTP code and count from mapper function 
        code, count = line.split('\t')
        yield (code, count)

def main():
    # Parse each line from standard input
    data = read_map_output(sys.stdin)
    
    # Aggregate over HTTP codes that appear in same map output
    for code, group in groupby(data, itemgetter(0)):
        # Cast HTTP code count from a string to an int
        # Sum counts for same HTTP code
        try:
            total_count = sum(int(count) for code, count in group)
            print '%s - %s' % (code, total_count)
        # If HTTP code count is not a number, then pass over this line
        except ValueError:
            pass    

if __name__ == "__main__":
    main()
