#!/bin/bash

# Set up the environment
dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devpts none /dev/pts
export HOME=/root
export LC_ALL=C
KERNEL=$(ls -Art /lib/modules | tail -n 1)
mv "/boot/initrd.fromiso" "/boot/initrd.img-$KERNEL"
mv "/boot/vmlinuz.fromiso" "/boot/vmlinuz-$KERNEL"
cd /build/

# Remve GNOME stuff
for pkg in gnome-calculator gnome-calendar \
gnome-characters gnome-control-center gnome-control-center-data \
gnome-control-center-faces gnome-desktop3-data \
gnome-font-viewer gnome-getting-started-docs \
gnome-initial-setup gnome-keyring gnome-keyring-pkcs11 gnome-logs \
gnome-mahjongg gnome-menus gnome-mines gnome-online-accounts \
gnome-power-manager gnome-screenshot gnome-session-bin gnome-session-canberra \
gnome-session-common gnome-settings-daemon gnome-settings-daemon-common \
gnome-shell gnome-shell-common gnome-shell-extension-appindicator \
gnome-shell-extension-desktop-icons gnome-shell-extension-ubuntu-dock \
gnome-startup-applications gnome-sudoku gnome-system-monitor gnome-terminal \
gnome-terminal-data gnome-themes-extra gnome-themes-extra-data gnome-todo \
gnome-todo-common gnome-user-docs gnome-video-effects \
nautilus-extension-gnome-terminal pinentry-gnome3 yaru-theme-gnome-shell;
do apt-get purge -y $pkg; done
apt -y autoremove
apt-get install -y software-properties-gtk

# Run the remix script
bash remix.sh && apt-get autoremove -y --purge

#mkdir newkernel && cd newkernel
#wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.1.4/amd64/linux-image-unsigned-6.1.4-060104-generic_6.1.4-060104.202301071207_amd64.deb
#wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.1.4/amd64/linux-modules-6.1.4-060104-generic_6.1.4-060104.202301071207_amd64.deb
#wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.1.4/amd64/linux-headers-6.1.4-060104-generic_6.1.4-060104.202301071207_amd64.deb
#wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v6.1.4/amd64/linux-headers-6.1.4-060104_6.1.4-060104.202301071207_all.deb
#dpkg -i *.deb
#cd .. && rm -r newkernel
#from https://9to5linux.com/you-can-now-install-linux-kernel-6-1-on-ubuntu-heres-how

apt upgrade -y
apt-get -y autoremove
apt-get -y autoclean
apt dist-upgrade -y
apt-get -y autoremove
apt-get -y autoclean
#-from https://elias.praciano.com/2014/08/apt-get-quais-as-diferencas-entre-autoremove-autoclean-e-clean/
apt --fix-broken install -y
apt-get autoremove -y --purge

# Clean up
update-initramfs -k all -u
apt-get -y clean
rm -f /var/lib/apt/lists/*_Packages
rm -f /var/lib/apt/lists/*_Sources
rm -f /var/lib/apt/lists/*_Translation-*
rm -rf /tmp/* ~/.bash_history
rm -rf /var/cache/ #from https://www.reddit.com/r/linuxmasterrace/comments/10vdiqs/cubic_ubuntu_iso_size_keeps_increasing/
echo -n > /etc/machine-id
rm -f /var/lib/dbus/machine-id
rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl
umount /proc || umount -lf /proc
umount /sys
umount /dev/pts
