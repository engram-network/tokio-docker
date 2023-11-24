# Engram Tokio Chain Testnet

```bash
Metadata
Status: Running
Flavor: Permissionless (Proof-of-Stake), to replace Tokio
Linux Epoch time: 1700672400 
Execution Version: London
Merge: At Genesis (0)
Shanghai time: 1700129868 (Nov/16, 2023, 08:53:32 UTC)
Capella epoch: 0
Cancun time: 1707809928
Deneb epoch: 20000
```

Header : 
```bash
"parent_hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
"fee_recipient": "0x0000000000000000000000000000000000000000",
"state_root": "0x535442de13070a081e4ec4649f5b2bf5e54439cec0089bf97990f7cf65a1b286",
"receipts_root": "0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
"logs_bloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
"prev_randao": "0x0000000000000000000000000000000000000000000000000000000000000000",
"block_number": "0",
"gas_limit": "25000000",
"gas_used": "0",
"timestamp": "1700129868",
"extra_data": "0x",
"base_fee_per_gas": "1000000000",
"block_hash": "0x80a844561ee9f1c08df22f27767950406ebeffad467739c2af0c4e5311569605",
"transactions_root": "0x7ffe241ea60187fdb0187bfa22de35d1f9bed7ab061d9401fd47e34a54fbede1",
"withdrawals_root": "0x0000000000000000000000000000000000000000000000000000000000000000"
```


Videos How to run Node Engram : [Striatum - Lighthouse Client](https://youtu.be/mkaovEDIASo)

This repository provides a docker-compose file to run a fully-functional, Testnet network for Engram Tokio with proof-of-stake enabled. This configuration uses Lighthouse as a consensus client and Striatum From Engram-Labs for execution.

The development net is fully functional and allows for the deployment of smart contracts and all the features that also come with the Lighthouse consensus client such as its rich set of APIs for retrieving data from the blockchain. This development net is a great way to understand the internals of Engram proof-of-stake and to mess around with the different settings that make the system possible.

`Note, this is an incentivized testnet if you complete it correctly.`

## Using

```
$ git clone https://github.com/engram-network/tokio-docker.git 
$ cd tokio-docker
$ git checkout dencun
$ chmod +x ./scripts/*.sh
$ ./scripts/install-docker.sh
$ ./scripts/install-asdf.sh
$ mkdir -p execution consensus
```

# Engram Network Validator Node Setup Guide
This guide will walk you through the process of depositing and running node on the Engram network.

### Prerequisites
Make sure you have ```eth2-val-tools``` and ```ethereal``` installed on your system.

wait until the binary installation is complete. and try to check

```sh
$ eth2-val-tools --help
$ ethereal version
```

### Deposit Steps
Once everything required is fulfilled, you need to create a mnemonic phrase to prepare the deposit data.

```console
$ eth2-val-tools mnemonic 
"female more wash genuine pilot slim exit mosquito glimpse blue science garlic creek upset acquire soup silent submit pitch spatial maple measure mutual picnic"
```
and keep your mnemonic!
> Not Your Key, Not Your Coin


Obtain the following parameters in validator-deposit-data.sh:

```console
$ nano ./scripts/validator-deposit-data.sh
```

```
amount: The amount of tGRAM to deposit (e.g., 32000000000)
smin: source min value (e.g., 0)
smax: source max value (e.g., 1)
withdrawals-mnemonic: your mnemonic phrase from generate eth2-val-tools.
validators-mnemonic: your mnemonic phrase from generate eth2-val-tools.
from: address that was already funded from the faucet.
privatekey: your privatekey address that has funds from the faucet.
```
Run the following command to generate final the deposit data.

```bash
bash ./scripts/validator-deposit-data.sh
```

> Wait for the deposit to be verified by smartcontract and check in explorer.


### Generate Public Keys
This step refers to deposit-data. You need to add the mnemonic phrase you have created in eth2-val-tools to extract in staking-cli and prepare the deposit-data to the on-chain.
```
$ ./scripts/validator-build.sh
```
--------
### Layout Staking Cli
```
$ ***Using the tool on an offline and secure device is highly recommended to keep your mnemonic safe.***

Please choose your language ['1. العربية', '2. ελληνικά', '3. English', '4. Français', '5. Bahasa melayu', '6. Italiano', '7. 日本語', '8. 한국어', '9. Português do Brasil', '10. român', '11. Türkçe', '12. 简体中文']:  [English]:

Choose English or Press Enter.

$ Please repeat the index to confirm: 

Type "0" since it is the minimum height the data deposit will be created at.

$ Please enter your mnemonic separated by spaces (" "). Note: you only need to enter the first 4 letters of each word if you'd prefer.:

Add your already created mnemonic phrase to be extracted into a public key.

$ Please choose the (mainnet or testnet) network/chain name ['mainnet-soon', 'devnet-1', 'devnet-3', 'devnet-4', 'devnet-5', 'testnet']:  [mainnet-soon]:

Choose testnet and Enter

$ Create a password that secures your validator keystore(s). You will need to re-enter this to decrypt them when you setup your Ethereum validators.:

Create your password with a minimum word of 8 letters/numbers and create a file with the name "password.txt" and save it in the "custom_config_data" folder
after completing creating a password you will be referred like this: 

███████╗███╗░░██╗░██████╗░██████╗░░█████╗░███╗░░░███╗  ████████╗░█████╗░██╗░░██╗██╗░█████╗░
██╔════╝████╗░██║██╔════╝░██╔══██╗██╔══██╗████╗░████║  ╚══██╔══╝██╔══██╗██║░██╔╝██║██╔══██╗
█████╗░░██╔██╗██║██║░░██╗░██████╔╝███████║██╔████╔██║  ░░░██║░░░██║░░██║█████═╝░██║██║░░██║
██╔══╝░░██║╚████║██║░░╚██╗██╔══██╗██╔══██║██║╚██╔╝██║  ░░░██║░░░██║░░██║██╔═██╗░██║██║░░██║
███████╗██║░╚███║╚██████╔╝██║░░██║██║░░██║██║░╚═╝░██║  ░░░██║░░░╚█████╔╝██║░╚██╗██║╚█████╔╝
╚══════╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝  ░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚═╝░╚════╝░      
                                                                  
Creating your keys.
Creating your keys:               [####################################]  32/32          
Creating your keystores:          [####################################]  32/32          
Creating your depositdata:        [####################################]  32/32          
Verifying your keystores:         [####################################]  32/32          
```

#### Configure Docker Compose
Change a few lines of code inside docker-compose.yml (if you want to use the default, and the execution options and beacon will adjust as well.)

```
identity=Huemint << Replace with your discord username (e.g: avenbreaks. don't add your hastag discord user or handle)

enr-address=13.210.210.210 << Replace with your public IPAddress

graffiti=Huemint << Replace with your unique name
```

After docker-compose.yml has been configured, Then run:
```
$ docker compose up -d
```

You will see the following:
```
$ docker compose up -d
[+] Running 4/4
 ⠿ Network tokio_default_default                           Created
 ⠿ Container striatum_init                                 Exited
 ⠿ Container striatum_el                                   Started
 ⠿ Container lighthouse_init                               Exited
 ⠿ Container lighthouse_cl                                 Started
 ⠿ Container lighthouse_vc                                 Started
```

Each time you restart, you can wipe the old data using `./clean.sh`.

Next, you can inspect the logs of the different services launched. 


```
$ docker logs striatum_el -f
```

see on striatum_el:
```
INFO [09-26|19:28:45.046] Forkchoice requested sync to new head    number=30729 hash=a38be3..648659 finalized=30652
INFO [09-26|19:28:57.045] Forkchoice requested sync to new head    number=30730 hash=eb3642..45f557 finalized=30652
INFO [09-26|19:29:09.046] Forkchoice requested sync to new head    number=30731 hash=b9fd32..3748bd finalized=30652
INFO [09-26|19:29:21.046] Forkchoice requested sync to new head    number=30732 hash=51ff7b..803756 finalized=30652
INFO [09-26|19:29:33.046] Forkchoice requested sync to new head    number=30733 hash=f80ac7..19e5f7 finalized=30652
```

```
$ docker logs lighthouse_cl -f
```

see on lighthouse_cl: 
```
INFO Subscribed to topics
INFO Sync state updated                      new_state: Evaluating known peers, old_state: Syncing Finalized Chain, service: sync
INFO Sync state updated                      new_state: Syncing Head Chain, old_state: Evaluating known peers, service: sync
INFO Sync state updated                      new_state: Synced, old_state: Syncing Head Chain, service: sync
INFO Subscribed to topics                    topics: ["/eth2/9c4e948f/bls_to_execution_change/ssz_snappy"]
INFO Successfully finalized deposit tree     finalized deposit count: 1, service: deposit_contract_rpc
```

```
$ docker logs lighthouse_vc -f
```

see on lighthouse_vc: 
```
INFO Connected to beacon node(s)             synced: 1, available: 1, total: 1, service: notifier
INFO All validators active                   slot: 32836, epoch: 1026, total_validators: 32, active_validators: 32
INFO Connected to beacon node(s)             synced: 1, available: 1, total: 1,
INFO Validator exists in beacon chain        fee_recipient: 0x617b…063d,
INFO Awaiting activation                     slot: 17409, epoch: 544, validators: 32, service: notifier
```

```
The logs above show the validator "Awaiting activation" meaning your node is on a waiting list, at least 30 minutes - 2 hours until your node is approved.
```

### Other Arguments

```FYI: if your node is stuck unable to pull sync and losing peers, you just stop docker then restart it. however if this solution does not solve you can replace the bootnode and noderecord here:```
[Consensus Specification](https://stryatum.s3.ap-southeast-1.amazonaws.com/custom_config_data.tar.xz).

```
When losing peers the normal logs will show up like this on consensus: 

striatum_el
WARN [10-03|04:50:47.133] Beacon client online, but no consensus updates received in a while. Please fix your beacon client to follow the chain! 
WARN [10-03|04:55:47.172] Beacon client online, but no consensus updates received in a while. Please fix your beacon client to follow the chain!

lighthouse_cl
INFO Oct 03 04:59:39.001 WARN Low peer count                          peer_count: 0, service: slot_notifier
WARN Oct 03 04:59:39.001 INFO Searching for peers                     current_slot: 78259, head_slot: 5248, finalized_epoch: 162, finalized_root: 0xa9c8…f1f7, peers: 0, service: slot_notifier
WARN Oct 03 04:59:39.001 WARN Syncing deposit contract block cache    est_blocks_remaining: initializing deposits, service: slot_notifier
```

## Available Features
- Deneb Fork Activation  
- The Striatum JSON-RPC API is available at http://striatum_el:8545
- The Lighthouse client's REST APIs are available at http://lighthouse_cl:5052
- Engram Validator Deposit Adress `0x4242424242424242424242424242424242424242` This can be used to onboard new validators into the network by depositing 32 tGRAM into the contract

