#!/bin/bash
#set -x

# prepare libs
apt update
apt upgrade -y
apt install libjpeg62-turbo-dev libconfig9 dnsmasq git cmake libusb-1.0-0-dev build-essential pkg-config libusb-1.0-0 \
  autoconf libtool i2c-tools libfftw3-dev libncurses-dev python3-serial jq ifplugd iptables automake iw -y

# install latest golang
cd /root
wget https://go.dev/dl/go1.20.linux-armv6l.tar.gz
rm -rf /root/go
rm -rf /root/go_path
tar xzf *.gz
rm *.gz

# install librtlsdr
cd /root
rm -rf /root/rtl-sdr
git clone https://github.com/osmocom/rtl-sdr.git
cd rtl-sdr
mkdir build
cd build
cmake ../ -DDETACH_KERNEL_DRIVER=ON -DINSTALL_UDEV_RULES=ON
make
make install
ldconfig
rm -rf /root/rtl-sdr

# install kalibrate-rtl
cd /root
rm -rf /root/kalibrate-rtl
git clone https://github.com/steve-m/kalibrate-rtl
cd kalibrate-rtl
./bootstrap && CXXFLAGS='-W -Wall -O3'
./configure
make -j8 && make install
rm -rf /root/kalibrate-rtl

# Prepare wiringpi for ogn trx via GPIO
cd /root && git clone https://github.com/wertyzp/WiringNP.git
cd WiringNP/
chmod 755 build
./build
cd /root && rm -r WiringNP


# clone stratux europe
cd /root
rm -r /root/stratux
git clone --recursive https://github.com/b3nn0/stratux.git /root/stratux

# clone the Nano Pi Neo Air specific files
rm -r /root/stratux-NPNA
git clone --recursive https://github.com/sternflyer/stratux-NPNA.git /root/stratux-NPNA

# copy various files from /root/stratux/image
cd /root/stratux/image
cp -f bashrc.txt /root/.bashrc
cp -f modules.txt /etc/modules
cp -f logrotate_d_stratux /etc/logrotate.d/stratux
cp -f logrotate.conf /etc/logrotate.conf
cp -f rtl-sdr-blacklist.conf /etc/modprobe.d/
cp -f stxAliases.txt /root/.stxAliases
cp -f stratux-dnsmasq.conf /etc/dnsmasq.d/stratux-dnsmasq.conf
cp -f wpa_supplicant_ap.conf /etc/wpa_supplicant/wpa_supplicant_ap.conf
cp -f sshd_config /etc/ssh/sshd_config
cp -f init-overlay /sbin/

# copy various files from /root/stratux-NPNA/NanoPiNeoAir
cd /root/stratux-NPNA/NanoPiNeoAir
cp -f rc.local /etc/rc.local
cp -f interfaces /etc/network/interfaces
cp -f interfaces.template /root/stratux/image
cp -f sensors.go /root/stratux/main/sensors.go
cp -f gps.go /root/stratux/main/gps.go
cp -f 99_ttyS1.rules /etc/udev/rules.d/
# disable swapfile
cp -f armbian-zram-config /etc/default/armbian-zram-config

#enable uart1 and i2c0 overlay
sed -i /boot/armbianEnv.txt \
    -e 's/\( \|^\)\(uart1\|i2c0\)\( \|$\)/ /g' \
    -e 's/^ //' -e 's/ $//' \
    -e 's#^\(.*overlays=.*\)$#\1'" uart1 i2c0"'#'

#rootfs overlay
cp -f overlayctl /sbin/
chmod 755 /sbin/overlayctl
overlayctl install
mkdir -p /overlay/robase # prepare so we can bind-mount root even if overlay is disabled

# prepare services
systemctl enable ssh
systemctl disable dnsmasq # we start it manually on respective interfaces
systemctl disable wpa_supplicant
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer

# Generate ssh key for all installs. Otherwise it would have to be done on each boot, which takes a couple of seconds
ssh-keygen -A -v

# build Stratux Europe
source /root/.bashrc
cd /root/stratux
make
make install

#disable NetworkManager
systemctl stop NetworkManager.service
systemctl disable NetworkManager.service
apt remove network-manager -y
ln -sf /var/run/resolvconf/resolv.conf /etc/resolv.conf

#clean up
apt autoremove -y
apt clean

# ask for reboot
echo
read -t 1 -n 10000 discard 
read -p "Reboot now? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  reboot
fi
