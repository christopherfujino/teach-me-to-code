#!/usr/bin/env python

import sys

def timestamp(args):
    '''Either get or set timestamp for a post'''
    filepath = args[0]
    print 'Going to timestamp %s' % filepath

if len(sys.argv) < 2:
    print 'Please provide a sub-command'
    exit(1)

SUB_COMMAND = sys.argv[1]
SUB_ARGS = sys.argv[2:]

if SUB_COMMAND == 'publish':
    publish(SUB_ARGS)
elif SUB_COMMAND == 'timestamp':
    timestamp(SUB_ARGS)
elif SUB_COMMAND == 'new':
    new(SUB_ARGS)
