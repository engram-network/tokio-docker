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
  wget https://go.dev/dl/go1.21.3.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.3.linux-amd64.tar.gz
  echo
  echo 
  printf '⚠️ ADD THIS LINE BELOW TO YOUR ~/.bashrc  ⚠️
  
  export PATH=$PATH:/usr/local/go/bin
\n'
  echo "Note: Changes made to a profile file may not apply until the next time you log into your computer. To apply the changes immediately, just run the shell commands directly or execute them from the profile using a command: source $HOME/.bashrc."
  echo
else
  echo "Skipping Golang installation."
fi