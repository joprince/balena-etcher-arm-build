#! /usr/bin/bash

sudo apt-get update --fix-missing
sudo apt-get install -y curl
sudo apt-get install -y python3
sudo apt-get install -y gcc
sudo apt-get install -y g++
sudo apt-get install -y make
sudo apt-get install -y libx11-dev
sudo apt-get install -y libxkbfile-dev
sudo apt-get install -y fakeroot
sudo apt-get install -y rpm
sudo apt-get install -y libsecret-1-dev
sudo apt-get install -y jq
sudo apt-get install -y python3-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python3-setuptools
sudo apt-get install -y libudev-dev
sudo apt-get install -y ruby-dev
sudo gem install fpm --no-document

#install NodeJS
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

#clone balena etcher
git clone --recursive https://github.com/balena-io/etcher
cd etcher
git checkout v1.7.8

#install python dependecies
pip3 install -r requirements.txt

make electron-develop

# restrict output to .deb package only to save build time
sed -i 's/TARGETS="deb rpm appimage"/TARGETS="deb"/g' scripts/resin/electron/build.sh

# Note: run `make electron-develop` before running build.
# use USE_SYSTEM_FPM="true" to force the use of the installed FPM version
USE_SYSTEM_FPM="true" make electron-build

sudo apt-get install -y ./dist/balena-etcher-electron_1.7.8+549d744d_armv7l.deb