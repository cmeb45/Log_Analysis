#!/usr/bin/env python

import sys

# Output all HTTP status codes with their respective counts

def read_input_file(filename):
    for line in filename:
        # Remove extra whitespace
        line = line.strip()
    
        # Break up line into individual terms
        terms = line.split()
    
        # HTTP status code is second-to-last term in Apache common access log
        code = terms[-2]
        yield code        

def main():
    # Parse each line from standard input
    data = read_input_file(sys.stdin)
    
    for code in data:
        # Send results to standard output
        print '%s\t%d' % (code, 1)
        

if __name__ == "__main__":
    main()
