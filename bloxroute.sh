
# Getting Data ENR From Docker Container
curl http://localhost:5052/eth/v1/node/identity | jq

# Run Docker BloxRouter
docker run --name bxgateway-go -d \
-v /home/ubuntu/gateway_log:/app/bloxroute/logs \
-v /home/ubuntu/ssl:/app/bloxroute/ssl \
-p 1801:1801 -p 28333:28333 bloxroute/bloxroute-gateway-go:v2.123.1 \
--blockchain-network Testnet \
--ws --port 1801 \
--enodes enode://feeb6589382276228b5bfe9aa6162df6027720f9f92681012dc695c28a7919c45cc8ed71a4a63182bdf65df2c3f8e22f794ed85a41b5f581b7fe1b377e8ae170@127.0.0.1:30303?discport=0 \
--multiaddr /ip4/<IPv4_NETWORK_ADDRESS>/tcp/<LISTENING_PORT>/p2p/<NODE_ID> \
--private-key <YOUR_PRIVATE_KEY> \
--eth-ws-uri ws://<ETH node IP address>:8546