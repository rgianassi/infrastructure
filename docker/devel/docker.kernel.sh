#!/bin/sh

######################
# Build WSL2 kernel with usb camera support
# menuconfig -> Device Drivers -> Multimedia support -> Filter media drivers
#            -> Device Drivers -> Multimedia support -> Media device types -> Cameras and video grabbers
#            -> Device Drivers -> Multimedia support -> Video4Linux options -> V4L2 sub-device userspace API
#            -> Device Drivers -> Multimedia support -> Media drivers -> Media USB Adapters -> USB Video Class (UVC)
#            -> Device Drivers -> Multimedia support -> Media drivers -> Media USB Adapters -> UVC input events device support
#            -> Device Drivers -> Multimedia support -> Media drivers -> Media USB Adapters -> GSPCA based webcams
######################

# remeber to connect with:
# usbipd wsl list (administrative powershell)
# usbipd wsl attach --busid 3-4 (powershell)
#
# usbipd.exe wsl list (terminal)
# usbipd.exe wsl attach --busid 3-4 (terminal)
#
# before running the browser, run guvcview and close it otherwise the webcam
# does not work at all; this way it works, but vivaldi/system continuosly
# enables and disables it, so is unusable.

VERSION=5.15.74.2
sudo apt update \
    && sudo apt upgrade -y \
    && sudo apt install -y build-essential flex bison libgtk2.0-dev \
    libelf-dev libncurses-dev autoconf libudev-dev libtool zip unzip \
    v4l-utils libssl-dev python3-pip cmake git iputils-ping net-tools \
    dwarves bc
sudo mkdir /usr/src
cd /usr/src
sudo git clone -b linux-msft-wsl-${VERSION} \
    https://github.com/microsoft/WSL2-Linux-Kernel.git ${VERSION}-microsoft-standard \
    && cd ${VERSION}-microsoft-standard
sudo cp /proc/config.gz config.gz
sudo gunzip config.gz
sudo mv config .config
sudo make menuconfig
sudo make -j$(nproc)
sudo make modules_install -j$(nproc)
sudo make install -j$(nproc)
sudo cp -rf vmlinux /mnt/c/Sources/
######################
# Record video in WSL
######################
sudo apt install v4l-utils guvcview ffmpeg
#sudo guvcview
