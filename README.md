# Lakka Retroflag NESPi 4 Safe-Shutdown Script
Simple script to setup a safe shutdown on Lakka+RetroFlag

Works on NESPi 4 only with Lakka nightlies dating 04/21 and afterwards. Lakka 3.0 should also work once it releases.

# How to install

## Enable Safe Shutdown on your NESPI case

- Enable the Safe Shutdown switch on your NESPI case as indicated by the manufacturer.

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
   
   `cd ~; curl -L "https://github.com/DevilBlackDeath/lakka-retroflag-nespi-safeshutdown/raw/master/install.sh" > lakka_retroflag_install.sh; bash lakka_retroflag_install.sh`
   
1. When asked about your timezone, refer to the "TZ database name" column in the following link :
- https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

# Credits
This is an updated version of the forked repository :
- https://github.com/halsafar/lakka-retroflag-safe-shutdown

It is updated to work with recent nightly builds of Lakka, including aarch64 ones, and to properly cut-off power on shutdown.Feel free to fork or copy this for your own needs, be it other Raspberry Pi cases with GPIO functionalities, futue Retroflag products compatibility, whatever else... :)

The original is a cleaned up version of:
- https://github.com/thiagoauler/lakka_nespi_power
- https://github.com/marcelonovaes/lakka_nespi_power

Inspired by:
- https://github.com/RetroFlag/retroflag-picase
