#!/bin/bash

set -e

date
ps axjf

#################################################################
# Update Ubuntu and install prerequisites for running Traw   #
#################################################################
sudo apt-get update
#################################################################
# Build Traw from source                                     #
#################################################################
NPROC=$(nproc)
echo "nproc: $NPROC"
#################################################################
# Install all necessary packages for building Traw           #
#################################################################
sudo apt-get install -y qt4-qmake libqt4-dev libminiupnpc-dev libdb++-dev libdb-dev libcrypto++-dev libqrencode-dev libboost-all-dev build-essential libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libssl-dev libdb++-dev libssl-dev ufw git
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

cd /usr/local
file=/usr/local/trawX
if [ ! -e "$file" ]
then
        sudo git clone https://github.com/trawproject/trawX.git
fi

cd /usr/local/trawX/src
file=/usr/local/trawX/src/trawd
if [ ! -e "$file" ]
then
        sudo make -j$NPROC -f makefile.unix
fi

sudo cp /usr/local/trawX/src/trawd /usr/bin/trawd

################################################################
# Configure to auto start at boot                                      #
################################################################
file=$HOME/.traw
if [ ! -e "$file" ]
then
        sudo mkdir $HOME/.traw
fi
printf '%s\n%s\n%s\n%s\n' 'daemon=1' 'server=1' 'rpcuser=u' 'rpcpassword=p' | sudo tee $HOME/.traw/traw.conf
file=/etc/init.d/traw
if [ ! -e "$file" ]
then
        printf '%s\n%s\n' '#!/bin/sh' 'sudo trawd' | sudo tee /etc/init.d/traw
        sudo chmod +x /etc/init.d/traw
        sudo update-rc.d traw defaults
fi

/usr/bin/trawd
echo "Traw has been setup successfully and is running..."
exit 0

