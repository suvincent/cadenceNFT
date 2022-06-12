// Setup Account

import ExampleNFT from "../cadence/contracts/ExampleNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20

// This transaction configures a user's account
// to use the NFT contract by creating a new empty collection,
// storing it in their account storage, and publishing a capability
transaction {
    prepare(acct: AuthAccount) {

        // Return early if the account already has a collection
        if acct.borrow<&ExampleNFT.Collection>(from: ExampleNFT.CollectionStoragePath) != nil {
            return
        }

        // Create a new empty collection
        let collection <- ExampleNFT.createEmptyCollection()

        // save it to the account
        acct.save(<-collection, to: ExampleNFT.CollectionStoragePath)

        log("Collection created for nftReceiver")

        // create a public capability for the Collection
        acct.link<&{NonFungibleToken.CollectionPublic, ExampleNFT.ExampleNFTCollectionPublic}>(
            ExampleNFT.CollectionPublicPath,
            target: ExampleNFT.CollectionStoragePath
        )

        log("Capability created")
    }
}
 