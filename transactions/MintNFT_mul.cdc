// Mint NFT

import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
// import NonFungibleToken from "../cadence/contracts/NonFungibleToken.cdc"
// import MetadataViews from "../cadence/contracts/MetadataViews.cdc"
// import FungibleToken from "../cadence/contracts/FungibleToken.cdc"


// This transaction allows the Minter account to mint an NFT
// and deposit it into its collection.

transaction(beforeUrl:String,afterUrl:String,bonus:String, num: Int, experience: String) {

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{NonFungibleToken.CollectionPublic}

    // The reference to the Minter resource stored in account storage
    let minterRef: &EverSinceNFT.NFTMinter

    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")
        
        // Borrow a capability for the NFTMinter in storage
        self.minterRef = acct.borrow<&EverSinceNFT.NFTMinter>(from: EverSinceNFT.MinterStoragePath)
            ?? panic("could not borrow minter reference")
    }

    execute {
        let metadata : {String : String} = {
          "bonus": bonus,
          "uri": beforeUrl,
          "usedUri":afterUrl,
          "experience": experience,
          "editionNumber": "3", //THIS CAN BE AN INTEGER OR A STRING
          "editionCount": "3",//THIS CAN BE AN INTEGER OR A STRING
          "royaltyAddress": "0xcd0f974468e9b489",//THIS CAN BE AN INTEGER OR A STRING
          "royaltyPercentage": "10.0"//THIS CAN BE AN INTEGER OR A STRING
        }
        // Use the minter reference to mint an NFT, which deposits
        // the NFT into the collection that is sent as a parameter.
        var i = 0
        while i < num {
            self.minterRef.mintNFT(recipient: self.receiverRef ,metadata: metadata)
            i = i+1
        }

        log("NFT Minted and deposited to nftOwner's Collection")
    }
}
 