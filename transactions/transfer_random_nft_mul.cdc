// Transfer

import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
// import NonFungibleToken from "../cadence/contracts/NonFungibleToken.cdc"

import NonFungibleToken from 0x631e88ae7f1d7c20

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction (receiver: Address, num: Int){

    // let transferMeta: { String : String }
    prepare(acct: AuthAccount) {

        // Borrow a reference from the stored collection
        let collectionRef = acct.borrow<&EverSinceNFT.Collection>(from: EverSinceNFT.CollectionStoragePath)
            ?? panic("Could not borrow a reference to the owner's collection")
        let recipient = getAccount(receiver)
        let receiverRef = recipient.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not borrow a reference to the receiver's collection")
        var i = 0
        while i < num {
            let ids = collectionRef.getIDs()  
            let r = unsafeRandom() % UInt64(ids.length)
            var transfer_target_id = ids[r] as UInt64
            var transferToken <- collectionRef.withdraw(withdrawID: transfer_target_id)
            receiverRef.deposit(token: <-transferToken)
            i = i+1
        }
    }

    execute {

    }
}
 