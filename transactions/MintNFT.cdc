// Mint NFT

<<<<<<< HEAD
import EverSinceNFT from 0xf8d6e0586b0a20c7
=======
import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
// import MetadataViews from "../cadence/contracts/MetadataViews.cdc"
// import FungibleToken from "../cadence/contracts/FungibleToken.cdc"

>>>>>>> 2d46cf9f2ad38e923dc5e2fe36ffe48c2abf6b0a

// This transaction allows the Minter account to mint an NFT
// and deposit it into its collection.

transaction(beforeUrl:String,afterUrl:String,bonus:String) {

    // The reference to the collection that will be receiving the NFT
<<<<<<< HEAD
    let receiverRef: &{EverSinceNFT.NFTReceiver}
=======
    let receiverRef: &{NonFungibleToken.CollectionPublic}
>>>>>>> 2d46cf9f2ad38e923dc5e2fe36ffe48c2abf6b0a

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
          "bonus": bonus,
          "uri": beforeUrl,
          "usedUri":afterUrl
        }
        // Use the minter reference to mint an NFT, which deposits
        // the NFT into the collection that is sent as a parameter.
        let newNFT = self.minterRef.mintNFT(recipient: self.receiverRef ,metadata: metadata)

        log("NFT Minted and deposited to nftOwner's Collection")
    }
}
 