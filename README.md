BTscreenlock
============

About
=====
BTscreenlock is a tool for automatically lock/unlock GNOME desktop based
on proximity of a pre-defined Bluetooth address (say, a cellphone)

DetectPhone
===========
This work is heavely inspired by prior art by vlachoudis(https://github.com/vlachoudis/DetectPhone)
There are, however few problems with DetectPhone:
- it works only with KDE;
- it's too brutal with killing screensaver, instead of politely asking it;
- it doesn't have provision for RSSI (see below).

RSSI
====
[RSSI](http://en.wikipedia.org/wiki/RSSI) stands for received signal strength
indicator, and in case of Bluetooth device is more or less proporional to the
distance between devices. This is something useful for BTscreenlock, as we can
use this to flexibly configure radius to which cellphone need to be removed
from PC for PC to lock itself.

Configuration
=============
Following variables are defined at the beginning of script. Adjust to taste:
- BTADDR - set to your cellphone address (run *hcitool scan* to detect it);
- LOCKCMD - leave default for Gnome, can reqire adjustments for other desktop
managers;
- UNLOCKCMD - leave default for Gnome, or set to empty string - "" for added
security (no auto unlock);
- LOCKTHRESHOLD - adjust to desirable lock distance
- UNLOCKTHRESHOLD - ditto for unlock distance
- DEBUG - set to "1" to make BTscreenlock extra verbose
