#!/bin/bash

# Inspired by [get_golang.sh](https://gist.github.com/n8henrie/1043443463a4a511acf98aaa4f8f0f69)
# I couldn't find a license for this ^, so... Here we are...
#
# Download latest Nebula VPN release binaries
# https://github.com/slackhq/nebula/releases/download/v1.4.0/nebula-linux-amd64.tar.gz
#
# The latest version of the script can be found here!
#   https://github.com/zarecor60/get-nebula

# Site-Specific variables
install_directory="/usr/local/bin/nebula.d"
arch="linux-amd64"

#future
## Options - main,client,lighthouse
#deploy_type="main"

search_string="\/download\/v([0-9\.]+)\/nebula-$arch\.tar\.gz"
echo "Finding latest version of Nebula for $arch..."
url="$(wget -qO- https://github.com/slackhq/nebula/releases/latest | grep -oP $search_string | head -n 1 )"
latest="$(echo $url | grep -oP 'v[0-9\.]+' | grep -oP '[0-9\.]+')"
full_url="https://github.com/slackhq/nebula/releases$url"
echo "Downloading latest Nebula for $arch: ${latest}"
wget $full_url
unset url
unset full_url

# Remove Old nebula version
echo "Removing old nebula binaries from $install_directory/"
sudo rm -rf $install_directory

# Install new nebula
sudo mkdir $install_directory
sudo tar -C $install_directory -xzf nebula-$arch.tar.gz
#echo "Setting PATH to include nebula binaries"
#PATH=$PATH:$install_directory
#echo $PATH >> ~/.profile

rm nebula-$arch.tar.gz
#
#
