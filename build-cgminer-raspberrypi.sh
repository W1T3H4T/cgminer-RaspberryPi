#!/bin/bash
##  ===========================================================================
##  File    :   build-cgminer-raspberrypi.sh
##  Notes   :   This script will build cgminer for GekkoScience Devices.
##          :   Originally developed to build cgminer on Raspberry Pi 5.
##  Who     :   David Means <w1t3h4t@gmail.com>
##  ===========================================================================

sudo apt update
sudo apt -y upgrade 
sudo apt install -y build-essential \
        autoconf \
        automake \
        libtool \
        pkg-config \
        libcurl4-openssl-dev \
        libudev-dev \
        libusb-1.0-0-dev \
        libncurses5-dev \
        zlib1g-dev \
        uthash-dev \
        git

AUTOGEN_PARAMS="--enable-gekko --enable-icarus"
CFLAGS="-O2 -march=native -fcommon -D_FORTIFY_SOURCE=1" ./autogen.sh $AUTOGEN_PARAMS
make clean
make

