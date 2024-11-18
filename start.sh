#!/bin/bash

# Remove stale PID files if they exist
rm -f /var/run/xrdp/xrdp-sesman.pid
rm -f /var/run/dbus/pid

# Start dbus
service dbus start

# Start PulseAudio in daemon mode
pulseaudio --start

# Give dbus some time to initialize
sleep 2

# Start xrdp-sesman and xrdp
service xrdp start

# Wait briefly and restart XRDP as a fallback to stabilize the connection
sleep 2
service xrdp restart

# Keep container running
tail -f /dev/null
