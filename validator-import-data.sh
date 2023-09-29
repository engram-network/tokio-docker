#!/bin/bash -e

lighthouse account validator import \
	  --testnet-dir "./custom_config_data" \
	  --datadir "./validator_keys" \
	  --directory "./consensus/validator" \
	  --password-file "./custom_config_data/jwtsecret" \
	  --reuse-password