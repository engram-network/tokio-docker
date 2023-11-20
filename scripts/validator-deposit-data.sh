#!/bin/bash

amount=32000000000
smin=0
smax=32

eth2-val-tools deposit-data \
  --source-min=$smin \
  --source-max=$smax \
  --amount=$amount \
  --fork-version=0x10000131 \
  --withdrawals-mnemonic="test test test test test test test test test test test junk" \
  --validators-mnemonic="test test test test test test test test test test test junk" > testnet_deposit_$smin\_$smax.txt

while read x; do
   account_name="$(echo "$x" | jq '.account')"
   pubkey="$(echo "$x" | jq '.pubkey')"
   echo "Sending deposit for validator $account_name $pubkey"
   ethereal beacon deposit \
      --allow-unknown-contract=true \
      --address="0x4242424242424242424242424242424242424242" \
      --connection=https://tokio-archive.engram.tech \
      --data="$x" \
      --allow-excessive-deposit \
      --value="$amount" \
      --from="0x000000000000000000000000000000000000000b" \
      --privatekey="0x000000000000.....................0000000000000"
   echo "Sent deposit for validator $account_name $pubkey"
   sleep 2
done < testnet_deposit_$smin\_$smax.txt
