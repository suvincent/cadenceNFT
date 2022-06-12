// Mint NFT

import EverSinceNFT from 0xf8d6e0586b0a20c7

// This transaction allows the Minter account to mint an NFT
// and deposit it into its collection.

transaction {

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{EverSinceNFT.NFTReceiver}

    // The reference to the Minter resource stored in account storage
    let minterRef: &EverSinceNFT.NFTMinter

    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability<&{EverSinceNFT.NFTReceiver}>(EverSinceNFT.CollectionPublicPath)
            .borrow()
            ?? panic("Could not borrow receiver reference")
        
        // Borrow a capability for the NFTMinter in storage
        self.minterRef = acct.borrow<&EverSinceNFT.NFTMinter>(from: EverSinceNFT.MinterStoragePath)
            ?? panic("could not borrow minter reference")
    }

    execute {
        let metadata : {String : String} = {
          "bonus": "5",
          "uri": "ipfs://QmdMBBGDsUhJwsJVovZCMbAY8HMnZTRSrLbET6qeS9D823"
        }
        // Use the minter reference to mint an NFT, which deposits
        // the NFT into the collection that is sent as a parameter.
        let newNFT <- self.minterRef.mintNFT()

        self.receiverRef.deposit(token: <-newNFT, metadata: metadata)

        log("NFT Minted and deposited to nftOwner's Collection")
    }
}
 