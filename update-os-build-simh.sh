#!/bin/sh
# This runs on the Ubuntu instance where SIMH will be run
#
# This is copied onto the instance by the "launch-vax.sh" script

# update the OS
# get dependencies for building SIMH
# build SIMH

# must run as root, obviously

set -v

##### get the 4.2 BSD tape to the local system

# get a bootable UNIX v6 PDP-11 tape image, need it for later
##wget http://sourceforge.net/projects/bsd42/files/Install%20tapes/Research%20Unix/Unix-v6-Ken-Wellsch.tap.bz2
##bunzip2 *.bz2

# put it in the right place for the emulator
##mv Unix-v6-Ken-Wellsch.tap dist.tap

date
# Begin with the Google standard Ubuntu 18.04 LTS (not the minimal)
#
# this should have been done by the instance creation script, but just in case...
# if you don't do this then a lot of the application packages won't install properly
# beside, its always a good idea to update+upgrade immediately after installation
sudo apt-get --yes update
sudo apt-get --yes upgrade

# you will need these packages to build the emulator
# this loads about a gazillion packages, so go get a beer
sudo apt-get --yes install build-essential unzip

# for video support
sudo apt-get --yes install libsdl2-dev
# for ethernet
sudo apt-get --yes libpcap-dev

#get the simh package and unpack
wget https://github.com/simh/simh/archive/master.zip
unzip master.zip
# creates a simh-master dir
cd simh-master

# time for another beer, maybe two
make vax780

# emulator is in BIN/pdp11

date

cd

# at this point, we have an emulator and a BSD tape














###############################





