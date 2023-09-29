amount=32000000000
smin=0
smax=1

eth2-val-tools deposit-data \
  --source-min=$smin \
  --source-max=$smax \
  --amount=$amount \
  --fork-version=0x10000130 \
  --withdrawals-mnemonic="galaxy.. decline" \
  --validators-mnemonic="galaxy .. decline" > testnet_deposit_$smin\_$smax.txt

while read x; do
   account_name="$(echo "$x" | jq '.account')"
   pubkey="$(echo "$x" | jq '.pubkey')"
   echo "Sending deposit for validator $account_name $pubkey"
   ethereal beacon deposit \
      --allow-unknown-contract=true \
      --address="0x4242424242424242424242424242424242424242" \
      --connection=https://engram.tech/testnet \
      --data="$x" \
      --allow-excessive-deposit \
      --value="$amount" \
      --from="0x285F1c6671108e88684fe3A8c966464A80E4c442" \
      --privatekey="0x6b737d36d588............6d0983ad283456889dc8fd0874" # the public key's private key
   echo "Sent deposit for validator $account_name $pubkey"
   sleep 2
done < testnet_deposit_$smin\_$smax.txt

