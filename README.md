# Lakka Retroflag NESPi 4 Safe-Shutdown Script
Simple script to setup a safe shutdown on Lakka+RetroFlag

Works on NESPi 4 only with Lakka nightlies dating ??? (pull request still in progress, once RPi.GPIO is officially included in Lakka, this script will work, for now you need a custom built Lakka, you can find the source of that custom build in my own forked Lakka-LIBREELEC)

# How to install

## Enable SSH In Lakka
1. Boot up Lakka
1. Connect your Raspberry Pi to the internet through either LAN or WiFi
1. Go to 'Settings -> Services -> SSH' : Turn this on

## Install scripts

1. ssh to your Pi
   For Linux/MAC :
   ```text
   ssh root@YOUR_LAKKA_IP_ADDRESS (you can find this in 'Main Menu -> Information > Network Information')
   password: root (if unchanged)
   ```
   
   For Windows, use the PuTTY SSH client
   
1. Type :
   
   `curl -L "https://github.com/DevilBlackDeath/lakka-retroflag-nespi-safeshutdown/raw/master/install.sh" > lakka_retroflag_install.sh; bash lakka_retroflag_install.sh`

# Credits
This is an updated version of the forked repository :
- https://github.com/halsafar/lakka-retroflag-safe-shutdown

It is updated to work with recent nightly builds of Lakka, including aarch64 ones, and to properly cut-off power on shutdown.

The original is a cleaned up version of:
- https://github.com/thiagoauler/lakka_nespi_power
- https://github.com/marcelonovaes/lakka_nespi_power

Inspired by:
- https://github.com/RetroFlag/retroflag-picase
