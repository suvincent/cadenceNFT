// Mint NFT

import ExampleNFT from "../cadence/contracts/ExampleNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
// import MetadataViews from "../cadence/contracts/MetadataViews.cdc"
// import FungibleToken from "../cadence/contracts/FungibleToken.cdc"


// This transaction allows the Minter account to mint an NFT
// and deposit it into its collection.

transaction {

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{NonFungibleToken.CollectionPublic}

    // The reference to the Minter resource stored in account storage
    let minterRef: &ExampleNFT.NFTMinter

    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability(ExampleNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")
        
        // Borrow a capability for the NFTMinter in storage
        self.minterRef = acct.borrow<&ExampleNFT.NFTMinter>(from: ExampleNFT.MinterStoragePath)
            ?? panic("could not borrow minter reference")
    }

    execute {
        let metadata : {String : String} = {
          "bonus": "5",
          "uri": "ipfs://QmdMBBGDsUhJwsJVovZCMbAY8HMnZTRSrLbET6qeS9D823"
        }
        // Use the minter reference to mint an NFT, which deposits
        // the NFT into the collection that is sent as a parameter.
        let newNFT = self.minterRef.mintNFT(recipient: self.receiverRef ,metadata: metadata)

        log("NFT Minted and deposited to nftOwner's Collection")
    }
}
 