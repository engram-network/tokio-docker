#!/bin/bash

printf "Installing All Dependencies...\n";
if prompt_user "Do you want to install dependencies?"; then
  sudo apt-get install gcc jq clang curl wget llvm chrony g++ -y
else
  echo "Skipping dependency installation."
fi

# Clone the asdf repository
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

# Add asdf to the current shell session
echo -e "\n. \$HOME/.asdf/asdf.sh" >> $HOME/.bashrc
echo -e "\n. \$HOME/.asdf/completions/asdf.bash" >> $HOME/.bashrc

# Source the updated .bashrc
source $HOME/.bashrc

# Display a message indicating successful installation
echo "asdf-vm installed successfully."

# Download and execute the Docker installation script
curl -sSL https://get.docker.com/ | sh

# Download Golang binary using asdf-vm
asdf plugin add golang 
asdf install golang 1.21.3
asdf global golang 1.21.3

# Installing eth2-val-tools to adding new mnemonics
go install github.com/protolambda/eth2-val-tools@latest
go install github.com/wealdtech/ethereal@latest

# Move eth2-val-tools
sudo mv $HOME/.asdf/installs/golang/1.21.3/packages/bin/eth2-val-tools /usr/local/bin
sudo mv $HOME/.asdf/installs/golang/1.21.3/packages/bin/ethereal /usr/local/bin