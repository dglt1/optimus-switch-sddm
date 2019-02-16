#!/bin/sh

####################################
# custom install script for SDDM   #
# and following GPU BusID's        #
# intel iGPU BusID  00:02:0        #
# nvidia dGPU BusID  01:00:0       #
# sudo chmod +x install.sh  first! #
####################################

# if you get these errors: "cp: cannot stat "/home/root/optimus-switch/*"
# it is because $USER is being read as "root" instead or your user name, to fixed
# this error, uncomment (remove #) the next line and specify username.

USER="dglt"

echo '##################################################################'
echo '# be sure you have all requirements BEFORE running this script  ##'
echo '# "pacman -S linux-headers acpi_call-dkms xf86-video-intel git" ##'
echo '# ****installing in 5 sec... CTRL+C to abort****                ##'
echo '##################################################################'
sleep 6
echo ' '
echo '##################################################################'
echo '#errors about removing files can be ignored, i wrote this script##'
echo '#with the most common files in mind, you will not have all of   ##'
echo '#them, this is ok!                                              ##'
echo '##################################################################'
echo '## IF YOU HAVE ERRORS ABOUT COPYING FILES, SOMETHING IS WRONG   ##'
echo '## MAKE SURE THIS IS RUN WITH SUDO AND FROM DIRECTORY           ##'
echo '## /home/$USER/optimus-switch/  (this is very important!!!)     ##'
echo '## cp: cannot stat "/home/root/optimus-switch/*"  can be fixed  ##'
echo '## by editing/replacing "$USER" with your username in install.sh##'
echo '## so far, has only happened with SDDM as far as i know.        ##'
echo '##################################################################'
sleep 5

echo ' '
echo 'Removing current nvidia prime setup if applicable, file not found can be ignored......'
rm -rf /etc/X11/mhwd.d/nvidia.conf
rm -rf /etc/X11/mhwd.d/nvidia.conf.nvidia-xconfig-original
echo 'Removing gpu configurations from /etc/X11/mhwd.d/  ........'
rm -rf /etc/X11/xorg.conf.d/90-mhwd.conf
rm -rf /etc/X11/xorg.conf.d/optimus.conf
echo 'Removing gpu configurations from /etc/X11/xorg.conf.d/ ........'
rm -rf /etc/modprobe.d/mhwd-gpu.conf
rm -rf /etc/modprobe.d/optimus.conf
rm -rf /etc/modprobe.d/nvidia.conf
echo 'Removing gpu configurations from /etc/modprobe.d/  ........'
rm -rf /etc/modprobe.d/nvidia-drm.conf
rm -rf /etc/modprobe.d/nvidia.conf
echo 'Removing gpu configurations from /etc/modules-load.d/'
rm -rf /etc/modules-load.d/mhwd-gpu.conf
echo 'removing any display setup scripts.....'
rm -rf /usr/share/sddm/scripts/Xsetup
rm -rf /usr/local/share/optimus.desktop
rm -rf /usr/local/bin/optimus.sh
sleep 2

echo 'Copying contents of ~/optimus-switch/* to /etc/ .......'
sudo cp -r /home/$USER/optimus-switch/* /etc/ 

sleep 2
echo 'Copying set-intel.sh and set-nvidia.sh to /usr/local/bin/'

cp /etc/switch/set-intel.sh /usr/local/bin/set-intel.sh

cp /etc/switch/set-nvidia.sh /usr/local/bin/set-nvidia.sh

###This section is intended for GDM and is not needed for LightDM or SDDM .
#cp /etc/switch/optimus.desktop /usr/local/share/optimus.desktop
#sleep 1
#echo 'Copying disable-nvidia.service to /etc/systemd/system/' 
#cp /etc/switch/intel/disable-nvidia.service /etc/systemd/system/disable-nvidia.service
#chown root:root /etc/systemd/system/disable-nvidia.service
#chmod 644 /etc/systemd/system/disable-nvidia.service

sleep 1
echo ' '
echo 'Setting nvidia prime mode (sudo set-nvidia.sh).......'

cp /etc/switch/nvidia/nvidia-mhwd.conf /etc/X11/mhwd.d/99-nvidia.conf
cp /etc/switch/nvidia/nvidia-xorg.conf /etc/X11/xorg.conf.d/99-nvidia.conf
cp /etc/switch/nvidia/nvidia-modprobe.conf /etc/modprobe.d/99-nvidia.conf
cp /etc/switch/nvidia/nvidia-modules.conf /etc/modules-load.d/99-nvidia.conf
cp /etc/switch/nvidia/optimus.sh /usr/share/sddm/scripts/Xsetup

sleep 1
echo ' '
echo 'Setting permissions........'
chmod +x /usr/local/bin/set-intel.sh
chmod +x /usr/local/bin/set-nvidia.sh
chmod a+rx /usr/share/sddm/scripts/Xsetup
chmod a+rx /etc/switch/intel/no-optimus.sh
chmod a+rx /etc/switch/nvidia/optimus.sh

sleep 1
echo ' '
echo ' '
echo 'Currently boot mode is set to nvidia prime.'
echo ' '
echo 'you can switch to intel only mode with sudo set-intel.sh and reboot.'
echo ' '
echo 'same can be done for nvidia prime mode with sudo set-nvidia.sh'
echo ' '
echo ' '
sleep 1
echo 'Install finished!'
echo ' '


 
 
