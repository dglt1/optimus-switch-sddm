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



#to find out what acpi_call disables your nvidia gpu,
#run this command
#
#` sudo /usr/share/acpi_call/examples/turn_off_gpu.sh ` 
#
#and see which acpi_call is returned as "works!" and then edit line 38 to match if needed.
#default BusID is set to 0000:01:00.0 (syntax is important) 
#be sure to edit lines 16,19,36,38,39 to match your BusID and working acpi_call if needed
#then uncomment lines 38,39


if [ -d "/sys/bus/pci/devices/0000:01:00.0" ]
then
  #echo '\_SB.PCI0.PEG0.PEGP._OFF' > /proc/acpi/call 
  #echo -n 1 > '/sys/bus/pci/devices/0000:01:00.0/remove' 

fi
