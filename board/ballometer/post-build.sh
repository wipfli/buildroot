#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# for wifi
cp package/busybox/S10mdev ${TARGET_DIR}/etc/init.d/S10mdev
chmod 755 ${TARGET_DIR}/etc/init.d/S10mdev
cp package/busybox/mdev.conf ${TARGET_DIR}/etc/mdev.conf
 
cp board/ballometer/interfaces ${TARGET_DIR}/etc/network/interfaces
cp board/ballometer/wpa_supplicant.conf ${TARGET_DIR}/etc/wpa_supplicant.conf
cp board/ballometer/sshd_config ${TARGET_DIR}/etc/ssh/sshd_config

cp board/ballometer/cmdline-p2.txt output/images/rpi-firmware/cmdline-p2.txt
cp board/ballometer/cmdline-p3.txt output/images/rpi-firmware/cmdline-p3.txt
cp board/ballometer/config.txt output/images/rpi-firmware/config.txt
cp board/ballometer/select.txt output/images/rpi-firmware/select.txt

cp board/ballometer/S60i2c ${TARGET_DIR}/etc/init.d/S60i2c
chmod 755 ${TARGET_DIR}/etc/init.d/S60i2c

