# optimus-switch for LightDM
- this is a more complete version of my previous lightDM setup scripts.
- includes an install script to remove conflicting configurations, blacklists, loading of drivers/modules. 
- made by a manjaro user for use with manjaro linux. (other distros would require modification)
- 
- this install script and accompanying scripts/.conf files will setup an intel/nvidia PRIME setup that will provide
- the best possible performance for your intel/nvidia optimus laptop. this will also allow for easy switching between
- intel/nvidia (prime) mode and an intel only mode that also completely powers down and removes the nvidia gpu
- from sight allowing for improved battery life, and not negatively effect sleep/suspend cycles (hangs/lockups).

  - this script by default is for an intel gpu with a ~~BusID 0:2:0~~
  - EDIT: intel BusID is only needed if intel drivers require it to work (i have not found this to be the case).
  - and an nvidia gpu with BusID 01:00:0`
  - you can verify this in terminal with this command `lspci | grep -E 'VGA|3D'`
  - if yours does not match, edit ~~/optimus-switch/switch/intel/intel-xorg.conf to match your BusID~~
  - and ~/optimus-switch/switch/nvidia/nvidia-xorg.conf  to match your nvidia BusID
  - DO THIS BEFORE RUNNING INSTALL SCRIPT, that is, if you want it to work anyway.
  - note: output like this "00:02.0 VGA " has to be formatted like this `0:2:0` in nvidia-xorg.conf for it to work properly.


Lets begin.
- requirements:
 - check `mhwd -li` to see what video drivers are installed, for this to work, you need only
 - video-nvidia installed, if you have others, start by removing them like this.
 - `sudo mhwd -r pci name-of-video-driver` (remove any/all mhwd installed gpu drivers besides video-nvidia.)
- if you dont already have video-nvidia installed, do that now:
- `sudo mhwd -i pci video-nvidia`
then:
 - `sudo pacman -S linux-headers acpi_call-dkms xf86-video-intel git` 
 - `sudo modprobe acpi_call`

- if you have any custom video/gpu .conf files in the following directories, backup/delete them. (they can not remain there).
- the install script removes the most common ones, but custom file names wont be noticed. only you know if they exist.
- and clearing the entire directory would likely break other things, this install will not do that. so clean up if necessary.
   - /etc/X11/
   - /etc/X11/mhwd.d/
   - /etc/X11/xorg.conf.d/
   - /etc/modprobe.d/
   - /etc/modules-load.d/
   -
- in terminal, from your home directory ~/  (this is important for the install script to work properly)
- 
- `git clone https://github.com/dglt1/optimus-switch.git`
- `sudo chmod +x ~/optimus-switch/install.sh`
- `cd ~/optimus-switch`
- `sudo ./install.sh`
- 
-  Done! after reboot you will be using intel/nvidia prime. 
- 
- to change the default mode to intel only, run:`sudo set-intel.sh`
- to switch the default mode to intel/nvidia prime, run: `sudo set-nvidia.sh`
- 
- Done!
-
- switch as often as you like. both intel mode and prime mode work without any issues that i know of, please make me aware - of any issues so i may fix them, or make note of how you have already fixed it for yourself.

- you may notice that after you boot into the intel only mode that the nvidia gpu is not yet disabled and its because you - cant run a proper test to see which acpi_call to use while using the nvidia gpu (it hard locks up the system).

- so once your booted into an intel only session run this in terminal:
- `sudo /usr/share/acpi_call/examples/turn_off_gpu.sh`

- you should see a list of various acpi calls, find the one that says “works!” , copy it. and then:
- `sudo nano /etc/switch/intel/no-optimus.sh`

- at the bottom you will see 2 lines #commented out, uncomment them (remove #) and if the acpi call is different from the - one you just copied, edit/replace with the good one. if your nvidia BusID is not 1:00:0 edit BusID's on both lines that - specify BusID's, save/exit.

- then:

- `sudo set-intel.sh`
- `reboot`

- the nvidia gpu should be disabled and no longer visible (inxi, mhwd, lspci wont see it). let me know how it goes, or if - you notice anything that could be improved upon. 

- note: if you see errors about “file does not exist” when you run install.sh its because it’s trying to remove the usual - mhwd-gpu/nvidia files that you may/may not have removed. only errors after "copying" starts should be of any concern. 
- if you could save the output of the install script if you are having issues. this makes it much easier to troubleshoot.


- usage after running install script:  

- `sudo set-intel.sh` will set intel only mode, reboot and nvidia powered off and removed from view.

- `sudo set-nvidia.sh`  sets intel/nvidia (prime) mode.

- this should be pretty straight forward, if however, you cant figure it out, i am @dglt on the manjaro forum. i hope this
- is as useful for you as it is for me.
