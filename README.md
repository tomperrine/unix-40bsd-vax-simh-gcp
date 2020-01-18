# unix-40bsd-vax-simh-gcp (renamed from vax-in-gcp)
tooling to automagically create a running 4.0 BSD system on a VaX-11 using simh in GCP

This software creates a full functional 4.0 BSD) system running on
an emulated VAX (using SIMH) in the Google Cloud (GCP).

You will need a 4.0BSD installation tape image. You can get it here:
* http://zazie.tom-yam.or.jp/starunix/
* http://zazie.tom-yam.or.jp/starunix/4.0bsd/4.0bsd.html



This uses several scripts and configuration files:

* launch-vax.sh - The master script creates a place to run the SIMH emulator.
  * creates a GCP instance running Ubuntu
* copies the update-os-build-simh.sh script onto the instance and runs it
  * displays information at the end to tell the user how to complete the installation
* update-os-build-simh.sh - gets SIMH VAX emulator running in the instance
  * updates Ubuntu
  * installs all needed dependencie
  * downloads, configures and builds SIMH for VAX
* vax-40bsd-first-boot.sh
  * runs the emulator with the tboot.init file which loads the OS from the boot tape file
  * it also "logs into" the 4BSD system and loads the /usr filesystem
  * when this script is complete you have a completely ready to log in 4.0BSD system
  

To begin just run "launch-vax.sh" from your local Mac or Linux machine, and watch the entire install process. This can take 6-12 minutes on a free "tiny" GCP instance.

Once the initial installation has finished, you log into the running Ubuntu image and run:
$simh-master/BIN/vax780 dboot.init and you will see

~~~~
  $ ./simh-master/BIN/vax780 dboot.init 
  VAX 11/780 simulator V4.0-0 Current        git commit id: 027c1de4
  Boot
  : hp(0,0)vmunix
  87844+15464+130300 start 0x530
  VM/UNIX (Berkeley Version 4.1) 11/10/80 
  real mem  = 8323072
  avail mem = 7860224
  Automatic reboot in progress...
  Tue Jan 13 18:57:49 PST 1976
  /dev/rp0a: 286 files 1896 blocks 5727 free
  /dev/rrp0g: 6041 files 33710 blocks 107868 free
  Tue Jan 13 18:57:53 PST 1976
  Mounted /usr on /dev/rp0g  
  preserving editor files
  clearing /tmp
  starting daemons: update cron accounting network mail.
  Tue Jan 13 18:57:53 PST 1976
  Virtual VAX/UNIX (Ernie Co-vax)
  login: 
~~~~

Log in with the username "root", no password. Note that 4.0BSD had no
network stack, so the only way to log into this emulated host is from
the Ubuntu command line.

In the future I hope to be able to attach the emulated serial card to
the Ubuntu host's TCP stack using the SIMH serial/TCP features.


REFERENCES

* https://sourceforge.net/projects/bsd42/files/Install%20tapes/4.0%20BSD/
* http://zazie.tom-yam.or.jp/starunix/
* http://zazie.tom-yam.or.jp/starunix/4.0bsd/4.0bsd.html


* http://gunkies.org/wiki/32v
* http://gunkies.org/wiki/Installing_32v_on_SIMH

* https://www.in-ulm.de/~mascheck/various/ancient/
* http://a.papnet.eu/UNIX/


* http://gunkies.org/wiki/4.2_BSD#How_do_I_get_this_to_run.3F.21
