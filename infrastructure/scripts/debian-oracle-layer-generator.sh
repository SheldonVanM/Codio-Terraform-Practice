#! /usr/bin/bash
echo 'Beginning generation of Python Oracle Connection Layer'

# First we will check if python 3 is installed
if ! python3.8 --version &>/dev/null; then
    echo 'Python version 3.8 is not installed. Installing now...'
    # update the package list
    sudo apt-get update

    # Install prereqs
    sudo apt-get install -y software-properties-common

    # Update package list
    sudo apt-get update

    # install python
    sudo apt-get install python3.8

    echo 'Python 3.8 installed successfully'
else
    echo 'Python is already installed. Continuing...'
fi

# Check if we have wget installed and if not then install it
if which wget >/dev/null; then
    echo 'wget is not installed! Installing now...'
    sudo apt-get update
    # Install wget
    sudo apt-get install -y wget
else
    echo 'wget is already installed... continuing'
fi

# Check if we have zip/unzip
if ! command -v zip &. /dev/null; then
    echo 'zip is not installed...'
    sudo apt-get install -y zip
else
    echo 'zip is already installed... continuing'
fi

# Making required directories
echo 'Making directories'
mkdir oracle-layer
cd oracle-layer/
mkdir python/ lib/
echo 'Required directories have been created!'

# Install cx_Oracle
pip3 install cx_Oracle -t python/

# Install the Oracle client
wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip -O oracle-client.zip

# Unzip the contents of the oracle client and place in lib/ directory
unzip -j oracle-client.zip -d lib/

# install libaio
sudo apt-get install libaio

# Copy into lib/ directory
cp /lib64/libaio.so.1 /lib/libaio.so.1

# Zip the file
zip -y -r oracle-layer.zip python/ lib/

# Finished
echo 'Complete!'
exit 0