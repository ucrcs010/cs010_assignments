#!/bin/bash

chmod u+rwx ~/.bin/ucr_cs/*

python ${PWD}/.bin/setup.py

rm -f $0

exit
