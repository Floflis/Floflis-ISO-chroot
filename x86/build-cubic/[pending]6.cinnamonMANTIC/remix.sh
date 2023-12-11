#!/bin/sh

add-apt-repository -y --no-update universe

apt-get install -y casper expect gparted cinnamon-desktop-environment \
 cifs-utils language-pack-en language-pack-gnome-en \
 xfsprogs jfsutils reiserfsprogs shim-signed shim ntfs-3g lvm2 \
 dmraid wamerican fwupdate mokutil ubuntu-settings \
 zram-tools
#get rid of ubuntucinnamon-desktop, for the sake of the latest Cinnamon
apt --fix-broken install

##########################################################
# uninstall snap, re-install snap (wont this uninstall the Installer?) from https://github.com/PJ-Singh-001/Cubic/issues/238#issuecomment-1674169063 ---->
apt purge snapd gnome-software-plugin-snap
apt install -y snapd gnome-software-plugin-snap --no-install-recommends
# <---- uninstall snap, re-install snap (wont this uninstall the Installer?) from https://github.com/PJ-Singh-001/Cubic/issues/238#issuecomment-1674169063

apt-get install -y gnome-shell --no-install-recommends && apt-get purge -y gnome-session ubuntu-session unity-greeter

glib-compile-schemas /usr/share/glib-2.0/schemas/

apt-get purge -y budgie-core --auto-remove
apt-get purge -y kinetic-core --auto-remove
apt-get purge -y lunar-core --auto-remove
apt-get purge -y mantic-core --auto-remove

apt-get -y autoremove
apt-get -y clean
apt-get -y autoclean
