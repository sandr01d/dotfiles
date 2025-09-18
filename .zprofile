#!/bin/bash

# Make sure to start the session only once per tty
if [ -z "${DISPLAY}" ]; then
	case "${XDG_VTNR}" in
	1)
		# Is set to tty when launched without a display manager
		export XDG_SESSION_TYPE=wayland
		niri-session -l
		;;
	esac
fi
