#!/bin/sh

add-apt-repository -y --no-update universe
add-apt-repository -y multiverse

#apt-get install -y casper expect gparted ubuntucinnamon-desktop \
# cifs-utils language-pack-en language-pack-gnome-en \
# xfsprogs jfsutils reiserfsprogs shim-signed shim ntfs-3g lvm2 \
# dmraid wamerican fwupdate mokutil ubuntu-settings \
# zram-tools ubiquity ubiquity-slideshow-ubuntu ubiquity-frontend-gtk

add-apt-repository ppa:ubuntuhandbook1/cinnamon # CUSTOM, HIGHLY EXPERIMENTAL
apt-get install -y casper expect gparted cinnamon-desktop-environment \
 cifs-utils language-pack-en language-pack-gnome-en \
 xfsprogs jfsutils reiserfsprogs shim-signed shim ntfs-3g lvm2 \
 dmraid wamerican fwupdate mokutil ubuntu-settings \
 zram-tools
#get rid of ubuntucinnamon-desktop, for the sake of the latest Cinnamon
apt --fix-broken install
dpkg -i --force-overwrite /var/cache/apt/archives/cinnamon_5.8.4-1build1~lunar_amd64.deb
apt upgrade cinnamon
apt upgrade cinnamon-core

#[MAYBE]Task of experiment, from Daniella: uninstall snap, re-install snap (wont this uninstall the Installer?)

apt-get install -y gnome-shell --no-install-recommends && apt-get purge -y gnome-session ubuntu-session unity-greeter

#cat > /usr/share/glib-2.0/schemas/90_ubuntucinnamon-wallpaper.gschema.override <<EOF
#[org.gnome.desktop.background]
#picture-uri='file:///usr/share/backgrounds/ubuntucinnamon/lunar/ubuntu_cinnamon_lunar_lobster.jpg'
#EOF

#[UNSELECTED BY DANI]apt-get install -y plymouth-theme-ubuntucinnamon-spinner

glib-compile-schemas /usr/share/glib-2.0/schemas/

apt-get purge -y budgie-core --auto-remove
apt-get purge -y kinetic-core --auto-remove
apt-get purge -y lunar-core --auto-remove
apt-get purge -y mantic-core --auto-remove #prepare for the upcoming Ubuntu 23.10

apt-get -y autoremove
apt-get -y clean
apt-get -y autoclean
