# Engram Tokio Chain Testnet

This repository provides a docker-compose file to run a fully-functional, Testnet network for Engram Tokio with proof-of-stake enabled. This configuration uses Lighthouse as a consensus client and Striatum From Engram-Labs for execution.

The development net is fully functional and allows for the deployment of smart contracts and all the features that also come with the Lighthouse consensus client such as its rich set of APIs for retrieving data from the blockchain. This development net is a great way to understand the internals of Engram proof-of-stake and to mess around with the different settings that make the system possible.

`Note, this is an incentivized testnet if you complete it correctly.`

## Using

```
$ git clone --recursive https://github.com/engram-network/tokio-docker.git 
$ cd tokio-docker
$ git checkout testnet
$ chmod +x ./scripts/*.sh
$ bash ./install-asdf.sh
$ mkdir -p execution consensus
```

#### Choose Client : 
```
docker-compose.yml : Stryatum - Lighthouse
docker-compose-besu.yml : Hyperledger Besu - Lighthouse
docker-compose-nethermind.yml : Nethermind - Lighthouse
docker-compose-reth.yml : RustETH - Lighthouse
```

Change a few lines of code inside docker-compose.yml (if you want to use the default, and the execution options and beacon will adjust as well.)

```
identity=avenbreaks << Replace with your discord username (e.g: avenbreaks. don't add your hastag discord user)

enr-address=13.210.210.210 << Replace with your public IPAddress

graffiti=avenbreaks << Replace with your unique name
```

Then, run:
```
$ docker compose up -d
```

You will see the following:
```
$ docker compose up -d
[+] Running 4/4
 ⠿ Network tokio_default_default                           Created
 ⠿ Container striatum_init                                 Started
 ⠿ Container striatum_el                                   Started
 ⠿ Container lighthouse_cl                                 Started
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
INFO Sync state updated      new_state: Evaluating known peers, old_state: Syncing Finalized Chain, service: sync
INFO Sync state updated      new_state: Syncing Head Chain, old_state: Evaluating known peers, service: sync
INFO Sync state updated      new_state: Synced, old_state: Syncing Head Chain, service: sync
INFO Subscribed to topics    topics: ["/eth2/9c4e948f/bls_to_execution_change/ssz_snappy"]
```

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
- Starts from the Altair Fork and going to Deneb Fork 
- The Striatum JSON-RPC API is available at http://striatum_el:8545
- The Lighthouse client's REST APIs are available at http://lighthouse_cl:5052
- Engram Validator Deposit Adress `0x11111c907e6ddfb954d5827c5b42cbca1ddc025e` This can be used to onboard new validators into the network by depositing 32 tGRAM into the contract

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
