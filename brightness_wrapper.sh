#!/bin/bash

# Wrapper script to handle brightness control with proper group permissions
# This is needed until you log out and back in for video group membership to take effect

newgrp video -c "/home/kabin/.config/i3/brightness_control.sh $1"
