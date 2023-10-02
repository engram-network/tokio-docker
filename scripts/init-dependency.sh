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

printf "Installing Golang Container...\n";
if prompt_user "Do you want to install Golang?"; then
  curl -fsSLo- https://s.id/golang-linux | bash
else
  echo "Skipping Golang installation."
fi