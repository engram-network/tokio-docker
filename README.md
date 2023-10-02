# Engram Tokio Chain Testnet

This repository provides a docker-compose file to run a fully-functional, Testnet network for Engram Tokio with proof-of-stake enabled. This configuration uses Lighthouse as a consensus client and Striatum From Engram-Labs for execution.

The development net is fully functional and allows for the deployment of smart contracts and all the features that also come with the Lighthouse consensus client such as its rich set of APIs for retrieving data from the blockchain. This development net is a great way to understand the internals of Engram proof-of-stake and to mess around with the different settings that make the system possible.

`Note, this is an incentivized testnet if you complete it correctly.`

## Using

```
$ git clone https://github.com/engram-network/tokio-docker.git 
$ cd tokio-docker
$ chmod +x ./scripts/*.sh
$ bash ./scripts/init-dependency.sh
$ mkdir -p execution consensus
```

Change a few lines of code inside docker-compose.yml

```
identity "Your-Identity" << Replace with your discord username
enr-address=xxx.xxx.xxx.xxx << Replace with your public IPAddress
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

## Available Features
- Starts from the ALTAIR Ethereum HardFork and preparation to ALTAIR HardFork 
- The Striatum JSON-RPC API is available at http://striatum_el:8545
- The Lighthouse client's REST APIs are available at http://lighthouse_cl:5052
- Engram Validator Deposit Adress `0x4242424242424242424242424242424242424242` This can be used to onboard new validators into the network by depositing 32 tGRAM into the contract
<br>
<br>
<br>
# Engram Network Validator Node Setup Guide
This guide will walk you through the process of depositing and running node on the Engram network.

### Prerequisites
Make sure you have ```eth2-val-tools``` and ```ethereal``` installed on your system.

```bash
$ bash ./scripts/dep-deposit.sh
```

wait until the binary installation is complete. and try to check

```sh
$ eth2-val-tools --help
$ ethereal version
```

If you cannot install automatically you can install manually and move the binary to the system folder, make sure you have installed golang:

```console
$ sudo apt-get install gcc jq clang llvm g++ -y
$ go version
$ go install github.com/protolambda/eth2-val-tools@latest
$ go install github.com/wealdtech/ethereal@latest

$ sudo mv $HOME/go/packages/bin/eth2-val-tools /usr/local/bin
$ sudo mv $HOME/go/packages/bin/ethereal /usr/local/bin
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