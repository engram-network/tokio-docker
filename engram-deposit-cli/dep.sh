amount=32000000000
smin=0
smax=1

eth2-val-tools deposit-data \
  --source-min=$smin \
  --source-max=$smax \
  --amount=$amount \
  --fork-version=0x10000130 \
  --withdrawals-mnemonic="giggle addict tribe outdoor rose chalk struggle claim zebra prize yellow depend match rally into enhance follow attend session industry stove dial remain regular" \
  --validators-mnemonic="giggle addict tribe outdoor rose chalk struggle claim zebra prize yellow depend match rally into enhance follow attend session industry stove dial remain regular" > testnet_deposit_$smin\_$smax.txt

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
      --from="0x841cabb0fba376019f879451adb88c95f30b0b20" \
      --privatekey="0x0ce2003ea0a665e9e38f43a376e77119cb6d725cfe8045d697bb32ef4b931139" # the public key's private key
   echo "Sent deposit for validator $account_name $pubkey"
   sleep 2
done < testnet_deposit_$smin\_$smax.txt