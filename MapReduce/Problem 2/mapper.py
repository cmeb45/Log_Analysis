#!/usr/bin/env python

import re
import sys

# Calculate total bandwidth sent by NASA webserver in July 1995

def is_nasa(string):
    # Check if webserver has NASA domain name
    out = re.search('nasa.gov',string)
    if out is not None:
       return True
    return False
    

for line in sys.stdin:
    # Remove extra whitespace
    line = line.strip()
    
    # Break up line into individual terms
    terms = line.split()

    # Webserver is first term in Apache common access log
    site = terms[0]        
    if is_nasa(site):
        # Response bytes is last term in Apache common access log
        bytes = terms[-1]
        print '%s\t%s' % ('nasa.gov',bytes)
