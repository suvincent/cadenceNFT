// Setup Account

import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x1d7e57aa55817448

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

        // save it to the account
        acct.save(<-collection, to: EverSinceNFT.CollectionStoragePath)

        log("Collection created for nftReceiver")

        // create a public capability for the Collection
        acct.link<&{NonFungibleToken.CollectionPublic, EverSinceNFT.EverSinceNFTCollectionPublic}>(
            EverSinceNFT.CollectionPublicPath,
            target: EverSinceNFT.CollectionStoragePath
        )

        log("Capability created")
    }
}