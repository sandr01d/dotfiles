#!/bin/bash

# Make sure to start the session only once per tty
if [ -z "${DISPLAY}" ]; then
	case "${XDG_VTNR}" in
	1) exec startx ;;
	2)
		# Use Firefox & Thunderbird with native Wayland instead of XWayland
		export MOZ_ENABLE_WAYLAND=1
		# Is set to tty when launched without a display manager
		export XDG_SESSION_TYPE=wayland
		dbus-run-session startplasma-wayland
		;;
	esac
fi
