#!/bin/bash

export DESKTOP_SESSION=plasma
# Is set to tty when launched without a display manager
export XDG_SESSION_TYPE=x11
# Using exec to make sure the user is logged out when the X server exits or crashes
exec startplasma-x11
