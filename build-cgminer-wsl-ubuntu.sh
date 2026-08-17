#!/bin/bash
##  ===========================================================================
##  File    :   build-cgminer-wsl-ubuntu.sh
##  Notes   :   This script will build cgminer for GekkoScience Devices.
##          :   In Ubuntu/WSL/RaspberryPi environments
##  ===========================================================================

apt_update() { 

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
}

do_build() { 
    make clean
    autoconf
    automake

    AUTOGEN_PARAMS="--enable-gekko --enable-icarus"
    CFLAGS="-O2 -march=native -fcommon -D_FORTIFY_SOURCE=2" ./autogen.sh $AUTOGEN_PARAMS
    make
}

show_help() {
    cat <<'EOF'
Usage: ./build-cgminer-wsl-ubuntu.sh [--apt-update] [--help]

Options:
  --apt-update  Update/install apt packages before building.
  --help        Show this help message and exit.

Unless --help is provided, the script runs do_build.
EOF
}

run_apt_update=false

while [ $# -gt 0 ]; do
    case "$1" in
        --apt-update)
            run_apt_update=true
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown argument: $1" >&2
            show_help >&2
            exit 1
            ;;
    esac
    shift
done

if [ "$run_apt_update" = true ]; then
    apt_update
fi

do_build
