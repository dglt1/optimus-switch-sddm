#!/bin/sh
# run at root before login dialog appears

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
