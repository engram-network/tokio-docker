# Engram Tokio Chain Semi-Mainnet

This repository provides a docker-compose file to run a fully-functional, Testnet network for Engram Tokio with proof-of-stake enabled. This configuration uses Lighthouse as a consensus client and Striatum From Engram-Labs for execution.

The development net is fully functional and allows for the deployment of smart contracts and all the features that also come with the Lighthouse consensus client such as its rich set of APIs for retrieving data from the blockchain. This development net is a great way to understand the internals of Engram proof-of-stake and to mess around with the different settings that make the system possible.

`Note, this is an incentivized testnet if you complete it correctly.`

## Using

install Docker First : 

```
chmod +x init.sh
./init.sh
wait until the installation is complete
```

Create Folder : 

```
git clone https://github.com/engram-network/tokio-docker.git && cd tokio-docker
./clean.sh
mkdir -p execution consensus 
change a few lines of code inside docker-compose.yml & docker-compose-validator.yml

--identity="Geth-EF" << Change with you customize identity
--enr-address=13.228.181.155 << Change with your public IP Address
--graffiti=YourName << Change with your custome name
```

Then, run:

```
docker compose up -d
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
docker logs striatum_el -f
```

and see:
```
INFO [09-26|19:28:45.046] Forkchoice requested sync to new head    number=30729 hash=a38be3..648659 finalized=30652
INFO [09-26|19:28:57.045] Forkchoice requested sync to new head    number=30730 hash=eb3642..45f557 finalized=30652
INFO [09-26|19:29:09.046] Forkchoice requested sync to new head    number=30731 hash=b9fd32..3748bd finalized=30652
INFO [09-26|19:29:21.046] Forkchoice requested sync to new head    number=30732 hash=51ff7b..803756 finalized=30652
INFO [09-26|19:29:33.046] Forkchoice requested sync to new head    number=30733 hash=f80ac7..19e5f7 finalized=30652
```

```
If you need monitoring to see the statistics of your servers and beacon nodes, you can use graphana labs or third-party automation such as Scale3Labs.
```

![Scale3Labs](https://kavn.sgp1.digitaloceanspaces.com/sui-grafana.png)

## Available Features
- Starts from the ALTAIR Ethereum HardFork and preparation to ALTAIR HardFork 
- The Striatum JSON-RPC API is available at http://striatum_el:8545
- The Lighthouse client's REST APIs are available at http://lighthouse_cl:5052
- Engram Validator Deposit Adress `0x4242424242424242424242424242424242424242` This can be used to onboard new validators into the network by depositing 32 tGRAM into the contract

## TO-DO 

- Setup Create Validator Deposit Address = Done
- Setup Docker Container Validator = Done
- Support Other Consensus Client = TODO
- Support Other Execution Client = TODO
- Support Sidechain & L2s = TODO