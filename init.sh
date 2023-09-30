#!/bin/bash

echo
echo
echo "                                                                 @@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                                              @@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                                        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                              @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "               @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo
echo

function prompt_user {
  while true; do
    read -p "$1 (y/n): " yn
    case $yn in
      [Yy]* ) return 0;;
      [Nn]* ) return 1;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

printf "Installing All Dependencies...\n";
if prompt_user "Do you want to install dependencies?"; then
  sudo apt-get install gcc jq clang curl wget llvm chrony g++ -y
else
  echo "Skipping dependency installation."
fi

printf "Installing Docker Container...\n";
if prompt_user "Do you want to install Docker?"; then
  curl -sSL https://get.docker.com/ | sh
else
  echo "Skipping Docker installation."
fi

# printf "Checking latest Go version...\n";
# LATEST_GO_VERSION="$(curl --silent https://go.dev/VERSION?m=text | head -n 1)";
# LATEST_GO_DOWNLOAD_URL="https://go.dev/dl/${LATEST_GO_VERSION}.linux-amd64.tar.gz"

# printf "cd to home ($USER) directory \n"
# cd $HOME

# printf "Downloading ${LATEST_GO_DOWNLOAD_URL}\n\n";
# if prompt_user "Do you want to download and install Go?"; then
# curl -OJ -L --progress-bar $LATEST_GO_DOWNLOAD_URL
# printf "Extracting file...\n"
# tar -xf ${LATEST_GO_VERSION}.linux-amd64.tar.gz

# export GOROOT="$HOME/go"
# export GOPATH="$HOME/go/packages"
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#  printf '⚠️  ADD (OR REPLACE) THIS LINE BELOW TO YOUR ~/.bashrc  ⚠️
# 
#  export GOROOT="$HOME/go"
#  export GOPATH="$HOME/go/packages"
#  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
#
#  and source $HOME/.bashrc or source $HOME/.profile
#  \n'

#  printf "You are ready to Go!";
#  go version
# else
#   echo "Skipping Go installation."
# fi

# Installing eth2-val-tools to adding new mnemonics
printf "Installing Core Pack New Deposit On Engram Tokio Chain...\n";
if prompt_user "Do you want to install eth2-val-tools and ethereal?"; then
  go install github.com/protolambda/eth2-val-tools@latest
  go install github.com/wealdtech/ethereal@latest

  printf "Move All Core Pack Deposit Data...\n";
  sudo mv $HOME/go/bin/eth2-val-tools /usr/local/bin
  sudo mv $HOME/go/bin/ethereal@latest /usr/local/bin
else
  echo "Skipping eth2-val-tools and ethereal installation."
fi
