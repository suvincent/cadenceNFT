// Setup Account

import EverSinceNFT from 0xf8d6e0586b0a20c7

// This transaction configures a user's account
// to use the NFT contract by creating a new empty collection,
// storing it in their account storage, and publishing a capability
transaction {
    prepare(acct: AuthAccount) {

        // Return early if the account already has a collection
        if acct.borrow<&EverSinceNFT.Collection>(from: EverSinceNFT.CollectionStoragePath) != nil {
            return
        }

        // Create a new empty collection
        let collection <- EverSinceNFT.createEmptyCollection()

        // store the empty NFT Collection in account storage
        acct.save<@EverSinceNFT.Collection>(<-collection, to: EverSinceNFT.CollectionStoragePath)

        log("Collection created for nftReceiver")

        // create a public capability for the Collection
        acct.link<&{EverSinceNFT.NFTReceiver}>(EverSinceNFT.CollectionPublicPath, target: EverSinceNFT.CollectionStoragePath)

        log("Capability created")
    }
}
 