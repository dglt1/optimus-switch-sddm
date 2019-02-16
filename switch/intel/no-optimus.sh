#!/bin/sh

#this script is run as a display setup script
#that replaces the one used by nvidia/prime.
##
#this powers-down/disables the nvidia dGPU and
#removes it from /sys/bus/pce/devices
#for the current boot. this is reset after reboot.
# PLEASE READ BELOW TO ENABLE THIS

xrandr --auto
echo 'auto' > '/sys/bus/pci/devices/0000:02:00.0/power/control'  #adjust busid if needed

#############
##make sure the line below is the correct acpi_call to disable your nvidia gpu. 
#to find out what call disables your nvidia gpu,
#run this (not while using nvidia gpu, this is why i left it commented out.
#
#` sudo /usr/share/acpi_call/examples/turn_off_gpu.sh ` 
#
#and see which acpi_call is returned as "works!" and then uncomment and edit this file to match.
#same goes for the the BusID of nvidia card, 
#default is set to 0000:01:00.0 (syntax is important) 
#if your nvidia gpu has a 1:0:1 busID, just uncomment the line, no change needed.

#echo '\_SB.PCI0.PEG0.PEGP._OFF' > /proc/acpi/call 
#echo -n 1 > '/sys/bus/pci/devices/0000:01:00.0/remove'
