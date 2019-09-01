# optimus-switch for SDDM
## Introduction
If you're using LightDM or GDM, you can get to those repo's here: https://github.com/dglt1. This includes an install script to remove conflicting configurations, blacklists, loading of drivers/modules.

*Made by a manjaro user for use with manjaro linux.* (other distros would requires modification)

## Features:
- It provides two modes of operation:
  - PRIME mode for best *performance* by utilizing nvidia GPU
  - intel mode for best *battery life* by utilizing intel GPU
- Easy switching between two modes mentioned above.
- In intel mode, nvidia GPU is completely powered off (won't be visible in `inxi -G` or `lscpi -v | grep -E 'VGA|3D'`) and not negatively effect sleep/suspend cycles (hangs/lockups).

## Before you begin
This script by default is for an intel gpu with a ~~BusID 0:2:0~~.

EDIT: intel BusID is only needed if intel drivers require it to work (I have not found this to be the case) and an nvidia gpu with BusID `01:00:0`. You can verify this in terminal with this command `lspci | grep -E 'VGA|3D'` if yours does not match, edit ~~/optimus-switch/switch/intel/intel-xorg.conf to match your BusID~~ and ~/optimus-switch-sddm/switch/nvidia/nvidia-xorg.conf  to match your nvidia BusID
DO THIS BEFORE RUNNING INSTALL SCRIPT, that is, if you want it to work anyway.
**NOTE**: output like this `00:02.0 VGA` has to be formatted like this `0:2:0` in nvidia-xorg.conf for it to work properly.

## Usage
### Requirements:
Check `mhwd -li` to see what video drivers are installed, for this to work, you need only `video-nvidia` installed, if you have others, start by removing them like this: `sudo mhwd -r pci name-of-video-driver` (remove any/all mhwd installed gpu drivers besides video-nvidia)
If you dont already have video-nvidia installed, do that now: `sudo mhwd -i pci video-nvidia` then:
`sudo pacman -S linuxXXX-headers acpi_call-dkms xorg-xrandr xf86-video-intel git` (replace linuxXXX-headers with the kernel version your using, for example linux419-headers is for the 4.19 kernel, so edit to match)
`sudo modprobe acpi_call` 
### Cleaning 
If you have any custom video/gpu .conf files in the following directories, backup/delete them (they can not remain there). The install script removes the most common ones, but custom file names won't be noticed (only you know if they exist) and clearing the entire directory would likely break other things, this install will not do that so clean up if necessary.
```
/etc/X11/
/etc/X11/mhwd.d/
/etc/X11/xorg.conf.d/
/etc/modprobe.d/
/etc/modules-load.d/
```
### Installation
In terminal, from your home directory ~/  (this is important for the install script to work properly)
 ```
git clone https://github.com/dglt1/optimus-switch-sddm.git
cd ~/optimus-switch-sddm
chmod +x install.sh
sudo ./install.sh
```
Done! after reboot you will be using intel/nvidia prime. 

To set modes (intel/nvidia)
- to change the default mode to intel only, run:`sudo set-intel.sh`
- to switch the default mode to intel/nvidia prime, run: `sudo set-nvidia.sh`
 
 read below!

 switch as often as you like. both intel mode and prime mode work without any issues that i know of, please make me aware - of any issues so i may fix them, or make note of how you have already fixed it for yourself.

 you may notice that after you boot into the intel only mode that the nvidia gpu is not yet disabled and its because you - cant run a proper test to see which acpi_call to use while using the nvidia gpu (it hard locks up the system).

 so once your booted into an intel only session run this in terminal:
 `sudo /etc/switch/gpu_switch_check.sh`

 you should see a list of various acpi calls, find the one that says “works!” , copy it. and then:
 `sudo nano /etc/switch/intel/no-optimus.sh`

 at the bottom you will see 2 lines #commented out, uncomment them (remove #) and if the acpi call is different from the - one you just copied, edit/replace with the good one. if your nvidia BusID is not 1:00:0 edit BusID's on both lines that - specify BusID's, save/exit.

 then:

 `sudo set-intel.sh`
 `reboot`

 the nvidia gpu should be disabled and no longer visible (inxi, mhwd, lspci wont see it). let me know how it goes, or if - you notice anything that could be improved upon. 

 note: if you see errors about “file does not exist” when you run install.sh its because it’s trying to remove the usual - mhwd-gpu/nvidia files that you may/may not have removed. only errors after "copying" starts should be of any concern. 
 if you could save the output of the install script if you are having issues. this makes it much easier to troubleshoot.


 usage after running install script:  

 `sudo set-intel.sh` will set intel only mode, reboot and nvidia powered off and removed from view.

 `sudo set-nvidia.sh`  sets intel/nvidia (prime) mode.

 this should be pretty straight forward, if however, you cant figure it out, i am @dglt on the manjaro forum. i hope this
 is as useful for you as it is for me.

 added side-note, for persistent changes to configurations, modify the configurations used for switching located in
- /etc/switch/nvidia/  and  /etc/switch/intel/  

