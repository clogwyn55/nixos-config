#!/usr/bin/env sh

# A one-time script to set up a system.

# necessary for XIVLauncher to work with flatpak Steam
mkdir -p ~/.steam/sdk64
ln ~/.var/app/com.valvesoftware.Steam/.steam/sdk64/steamclient.so ~/.steam/sdk64

# This makes Halo MCC multiplayer work

