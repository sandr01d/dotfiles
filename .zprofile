#!/bin/bash

# Make sure to start the session only once per tty
if [ -z "${DISPLAY}" ]; then
	case "${XDG_VTNR}" in
	1)
		niri-session -l
		;;
	esac
fi
