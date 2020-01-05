#!/bin/sh

#this script is run as a display setup script
#that replaces the one used by nvidia/prime.
##
#this powers-down/disables the nvidia dGPU and
#removes it from /sys/bus/pce/devices
#for the current boot. this is reset after reboot.
# PLEASE READ BELOW TO ENABLE THIS

xrandr --auto

#This ensures that LightDM doesn't fail after locking the screen or logging out
#edit "0000:01:00.0" to match your bus id if it's different.

if [ -d "/sys/bus/pci/devices/0000:01:00.0" ]
then

  echo 'auto' > '/sys/bus/pci/devices/0000:01:00.0/power/control'  #adjust busid if needed

fi

#############
##make sure the line below is the correct acpi_call to disable your nvidia gpu. 
#to find out what call disables your nvidia gpu,
#run this (not while using nvidia gpu, this is why i left it commented out.
#
#` sudo /usr/share/acpi_call/examples/turn_off_gpu.sh ` 
#
#and see which acpi_call is returned as "works!" and then edit line 37 to match.
#default BusID is set to 0000:01:00.0 (syntax is important) 
#if your nvidia gpu has a 1:0:0 busID, just uncomment the line 35 below, if not
#edit lines 16,19,35, and 38 to match your BusID

if [ -d "/sys/bus/pci/devices/0000:01:00.0" ]
then
  #echo '\_SB.PCI0.PEG0.PEGP._OFF' > /proc/acpi/call 
  #echo -n 1 > '/sys/bus/pci/devices/0000:01:00.0/remove' 

fi
