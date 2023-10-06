#!/bin/bash 

# create validator keystore and generate new-mnemonics
docker run -it --rm -v $(pwd)/validator_keys:/app/validator_keys engramnet/staking-cli:latest new-mnemonic --num_validators=1 --mnemonic_language=english --folder=validator_keys

