#!/bin/bash

# given a GCP, etc account and the SDK on the install-from host, build and install a new server

# set the needed environment vars
. ../cloud-configuration/set-cloud-configuration.sh

. ./instance-name.sh

# does the instance we're going to create already exist?
# Note - the command doesn't return a usable exit code so we have to test separately
tt=`gcloud compute instances list --filter="name=($INSTANCENAME)" | grep $INSTANCENAME | wc -l `
if [ $tt != '0' ] ; then
    echo "instance $INSTANCENAME already exists... exiting"
    exit 1
fi

echo "launching instance, patching (can take up to 10 minutes on a tiny)..."
../create-simple-google-instance/create-instance.sh

# at some point we need to get the main distro tape files
# For now, assume that we've already fetched them
# https://sourceforge.net/projects/bsd42/files/Install%20tapes/4.0%20BSD/4.0bsd.tap.bz2/download
# https://downloads.sourceforge.net/project/bsd42/Install%20tapes/4.0%20BSD/4.0bsd.tap.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fbsd42%2Ffiles%2FInstall%2520tapes%2F4.0%2520BSD%2F4.0bsd.tap.bz2%2Fdownload%3Fuse_mirror%3Dmaster%26r%3D%26use_mirror%3Dmaster&ts=1571978042
# this gives you a file starunix.tar.bz2
# bunzip it and untar it
#bunzip2 starunix.tar.bz2 
#tar xvf starunix.tar
# the files we want are in starunix/4.0bsd/
# DONT COPY THE INIT FILES AS WE HAVE OUR OWN
#cp starunix/4.0bsd/boot starunix/4.0bsd/4.0bsd.tape .

# put the main install script on the host and run it
# dont return here until the OS is running, all packages have been installed
echo "copying files..."
gcloud compute scp update-os-build-simh.sh vax-40bsd-first-boot.sh *.init starunix/4.0bsd/boot starunix/4.0bsd/4.0bsd.tape  ${CLOUD_USERNAME}@${INSTANCENAME}: --project ${PROJ} --zone ${CLOUDSDK_COMPUTE_ZONE}

echo "setting +x modes"
gcloud compute ssh ${CLOUD_USERNAME}@${INSTANCENAME} --project ${PROJ} --zone ${CLOUDSDK_COMPUTE_ZONE} -- chmod +x update-os-build-simh.sh vax-40bsd-first-boot.sh

echo "running update-os-build-simh..."
gcloud compute ssh ${CLOUD_USERNAME}@${INSTANCENAME} --project ${PROJ} --zone ${CLOUDSDK_COMPUTE_ZONE} -- './update-os-build-simh.sh'

echo "running vax-40bsd0first-boot..."
gcloud compute ssh ${CLOUD_USERNAME}@${INSTANCENAME} --project ${PROJ} --zone ${CLOUDSDK_COMPUTE_ZONE} -- './vax-40bsd-first-boot.sh

echo 'OS and SIMH installed. 4.0BSD installed into emulated VAX780.:
echo "Log into the Ubunto instance and use \$simh-master/BIN/vax780 dboot.init to start the emulator, log in as 'root'"

exit
