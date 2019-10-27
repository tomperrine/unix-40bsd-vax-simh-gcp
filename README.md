# unix-40bsd-vax-simh-gcp (renamed from vax-in-gcp)
tooling to automagically create a running BSD system on a VaX-11 using simh in GCP

This software creates a full functional 4.0 BSD) system running on
an emulated VAX (using SIMH) in the Google Cloud (GCP).

This uses several scripts and configuration files:

* launch-vax.sh - The master script creates a place to run the SIMH emulator.
  * creates a GCP instance running Ubuntu
* copies the update-os-build-simh.sh script onto the instance and runs it
  * displays information at the end to tell the user how to complete the installation
* update-os-build-simh.sh - gets SIMH VAX emulator running in the instance
  * updates Ubuntu
  * installs all needed dependencie
  * downloads, configures and builds SIMH for VAX

At the end of this process you have a running Ubuntu system with a VAX emulator ready to install 4 BSD

######
######
The end of the launch-pdp11.sh script provides instructions on how to install V6 UNIX into the emulator. This erquires running three commands while logged into the GCP Ubuntu instance:


simh VAX in GCP


References

https://sourceforge.net/projects/bsd42/files/Install%20tapes/4.0%20BSD/
http://gunkies.org/wiki/32v

http://gunkies.org/wiki/Installing_32v_on_SIMH
https://www.in-ulm.de/~mascheck/various/ancient/
http://a.papnet.eu/UNIX/


http://zazie.tom-yam.or.jp/starunix/
http://zazie.tom-yam.or.jp/starunix/4.0bsd/4.0bsd.html


http://gunkies.org/wiki/4.2_BSD#How_do_I_get_this_to_run.3F.21
