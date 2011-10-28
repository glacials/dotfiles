#!/usr/bin/env python

import os
import re
import sys

undir = sys.argv[1]

f = open(undir + '/history', 'r')
l = f.read().splitlines()[-2]

a = l.split(' ')

# Remove blanks
a = [x for x in a if x]
# Remove line number
a.pop(0)

c = a.pop(0)

try:
	f = open(undir + '/templates/' + c);
except IOError as e:
	exit('I don\'t know how to undo ' + c)

u = f.read()

for k, v in enumerate(a):
	u = u.replace('$' + str(k), v)

sys.stdout.write(u)
inp = input('Confirm? [Y/n] ')

if inp.lower() == 'y' or len(inp) == 0:
	os.system(u)
