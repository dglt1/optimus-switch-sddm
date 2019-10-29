#!/bin/sh

#requires intel driver from xf86-video-intel
#unless you replace intel-xorg.conf 
#with modeset.xorg.conf on the line below.
echo 'Removing nvidia prime setup......'

rm -rf /etc/X11/xorg.conf.d/99-nvidia.conf
rm -rf /etc/modprobe.d/99-nvidia.conf
rm -rf /etc/modules-load.d/99-nvidia.conf
rm -rf /usr/share/sddm/scripts/Xsetup

sleep 1
echo 'Setting intel only mode.......'
cp /etc/switch/intel/intel-xorg.conf /etc/X11/xorg.conf.d/99-intel.conf
cp /etc/switch/intel/intel-modprobe.conf /etc/modprobe.d/99-intel.conf
cp /etc/switch/intel/no-optimus.sh /usr/share/sddm/scripts/Xsetup
sleep 1
echo 'Done! After reboot you will be using intel only mode with the nvidia gpu disabled.'

