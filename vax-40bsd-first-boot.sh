#!/bin/sh
# This runs on the Ubuntu instance where SIMH will be run
#
# This is copied onto the instance by the "launch-vax.sh" script

# update the OS
# get dependencies for building SIMH
# build SIMH

# must run as root, obviously

set -v

# Do the first boot, this will actually install 4.0BSD from "tape" onto the emulated RP06
echo 'y' | simh-master/BIN/vax780 tboot.init


