#!/bin/bash

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

# Installing eth2-val-tools to adding new mnemonics
printf "Installing Core Pack New Deposit On Engram Tokio Chain...\n";
if prompt_user "Do you want to install eth2-val-tools and ethereal?"; then
  go install github.com/protolambda/eth2-val-tools@latest
  go install github.com/wealdtech/ethereal@latest
else
  echo "Skipping move binary files."
fi

printf "Move All Core Pack Deposit Data...\n";
  sudo mv $HOME/go/packages/bin/eth2-val-tools /usr/local/bin
  sudo mv $HOME/go/packages/bin/ethereal /usr/local/bin
else
  echo "Skipping eth2-val-tools and ethereal installation."
fi