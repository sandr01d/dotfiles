#!/bin/bash

# Make sure to start the session only once per tty
if [ -z "${DISPLAY}" ]; then
	case "${XDG_VTNR}" in
	1)
		# Use Firefox & Thunderbird with native Wayland instead of XWayland
		export MOZ_ENABLE_WAYLAND=1
		# Is set to tty when launched without a display manager
		export XDG_SESSION_TYPE=wayland
		startplasma-wayland
		;;
	2) exec startx ;;
	esac
fi
