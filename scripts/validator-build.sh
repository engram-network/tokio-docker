docker run -it --rm -v $(pwd)/validator_keys:/app/validator_keys registry.digitalocean.com/cri-private/engramnet/staking-deposit-cli:v2 existing-mnemonic --num_validators=1 --validator_start_index=0
