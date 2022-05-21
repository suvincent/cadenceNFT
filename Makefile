define NFTOwner
$(shell node -p "require('./flow.json').accounts.testnetOwner.address")
endef

define NFTReceiver
$(shell node -p "require('./flow.json').accounts.testnetReceiver.address")
endef

UseNFT_index := 1
TransferNFT_index := 2
Print1NFT_Addr := $(NFTOwner)
PrintNFT_Addrs := $(NFTOwner) $(NFTReceiver)

emulate: 
	flow project start-emulator --config-path=flow.json --verbose

init:
	flow accounts create --key e72f093d0265c6db6226221eeba446bae68c4e0159d49d388d33f3e3ca27c2afa5faddfeaa6c34cf1d0c19041b7e154fe9b87799e0c6a817dc429febe934e4d8 --signer emulator-account

deployNFT: 
	flow accounts add-contract ExampleNFT ./cadence/contracts/ExampleNFT.cdc 

mintNFT:
	flow transactions send ./transactions/MintNFT.cdc --signer emulator-account

useNFT:
	flow transactions send ./transactions/useNFT.cdc $(UseNFT_index) --signer test

setup_account:
	flow transactions send ./transactions/setup_account.cdc --signer test

transferNFT:
	flow transactions send ./transactions/transfer_nft.cdc  $(NFTReceiver) $(TransferNFT_index) --signer emulator-account

transferRandomNFT:
	flow transactions send ./transactions/transfer_random_nft.cdc  0x01cf0e2f2f715450 --signer emulator-account

print1NFT:
	flow scripts execute ./scripts/print_1_nft.cdc $(Print1NFT_Addr)

printNFT:
	flow scripts execute ./scripts/print_nft.cdc $(PrintNFT_Addrs)

generateAccountOnTestnet:
	flow keys generate 

deployContractToTestnet:
	flow project deploy --network=testnet --update

TestnetMintNFTTx:
	$(shell rm signed.rlp) \
	$(shell rm tx1) \
	flow transactions build ./transactions/MintNFT.cdc --proposer testnetOwner  --payer testnetOwner  --authorizer testnetOwner --filter payload --save tx1 --network=testnet
	flow transactions sign tx1 --signer testnetOwner --filter payload --save signed.rlp --network=testnet
	flow transactions send-signed signed.rlp --network=testnet

TestnetSetupAccountTx:
	$(shell rm signed.rlp) \
	$(shell rm tx1) \
	flow transactions build ./transactions/setup_account.cdc --proposer testnetReceiver  --payer testnetReceiver  --authorizer testnetReceiver --filter payload --save tx1 --network=testnet
	flow transactions sign tx1 --signer testnetReceiver --filter payload --save signed.rlp --network=testnet
	flow transactions send-signed signed.rlp --network=testnet


TestnetTransferNFT:
	$(shell rm signed.rlp)\
	$(shell rm tx1)\
	flow transactions build ./transactions/transfer_nft.cdc $(NFTReceiver) $(TransferNFT_index) --proposer testnetOwner  --payer testnetOwner  --authorizer testnetOwner --filter payload --save tx1 --network=testnet
	flow transactions sign tx1 --signer testnetOwner --filter payload --save signed.rlp --network=testnet
	flow transactions send-signed signed.rlp --network=testnet

TestnetTransferRandomNFT:
	$(shell rm signed.rlp)\
	$(shell rm tx1)\
	flow transactions build ./transactions/transfer_random_nft.cdc $(NFTReceiver) --proposer testnetOwner  --payer testnetOwner  --authorizer testnetOwner --filter payload --save tx1 --network=testnet
	flow transactions sign tx1 --signer testnetOwner --filter payload --save signed.rlp --network=testnet
	flow transactions send-signed signed.rlp --network=testnet

TestnetUseNFT:
	$(shell rm signed.rlp)\
	$(shell rm tx1)\
	flow transactions build ./transactions/useNFT.cdc $(UseNFT_index) --proposer testnetOwner  --payer testnetOwner  --authorizer testnetOwner --filter payload --save tx1 --network=testnet
	flow transactions sign tx1 --signer testnetOwner --filter payload --save signed.rlp --network=testnet
	flow transactions send-signed signed.rlp --network=testnet
	
TestNetprint1NFT:
	flow scripts execute ./scripts/print_1_nft.cdc $(Print1NFT_Addr) --network=testnet

TestNetprintNFT:
	flow scripts execute ./scripts/print_nft.cdc $(PrintNFT_Addrs) --network=testnet
