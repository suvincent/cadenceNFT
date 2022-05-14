# flow NFT
## Explorer
https://testnet.flowscan.org/
 
## Description

there are two account in transfer step, NFT owner and receiver

### Steps:
1. OWNER deploy contract on flow chain ,and create collection to owner's account
(output : AccountContractAdded -> 0x2f55...(example))
2. OWNER mint and deposit NFT to owner's collection
3. RECEIVER create collection for his account
4. OWNER transfer NFT to receiver

### Test Steps;
1. test on emulator (O)
-> put meatadata in NFT (O)
-> random mint NFT
-> renew metadata(bonus)
-> constraint: no bonus, no transfer(o)
-> change name ->account to owner / receiver
-> in makefile, _nft -> NFT(o)

2. test on testnet (use explorer on testnet)
-> check cmd for whale steps

### CLI-script
* start emulater
```
flow project start-emulator --config-path=flow.json --verbose
```

* deploy contract
```
// command
flow accounts add-contract $CONTRACT_NAME $CONTRACT_PATH
// example
flow accounts add-contract ExampleNFT ./cadence/contracts/ExampleNFT.cdc 
```

* send transactions
```
// command
flow transactions send $TRANSACTION_PATH --signer $SIGNER
// example
flow transactions send ./transactions/MintNFT.cdc --signer emulator-account
```
* send script
```
// command
flow scripts execute $TRANSACTION_PATH
// example
flow scripts execute ./transactions/MintNFT.cdc
```
* create account
```
flow accounts create --key --signer
```
* create key
```
flow keys generate
```
## Reference:
* random function : https://docs.onflow.org/cadence/language/built-in-functions/#unsaferandom

