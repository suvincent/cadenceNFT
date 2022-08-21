// Transfer

import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
// import NonFungibleToken from "../cadence/contracts/NonFungibleToken.cdc"

import NonFungibleToken from 0x1d7e57aa55817448

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction (receiver: Address, nums: [Int], sku:[String]){

    // let transferMeta: { String : String }
    prepare(acct: AuthAccount) {

        // Borrow a reference from the stored collection
        let collectionRef = acct.borrow<&EverSinceNFT.Collection>(from: EverSinceNFT.CollectionStoragePath)
            ?? panic("Could not borrow a reference to the owner's collection")
        // Borrow a capability for the NFTMinter in storage
        let minterRef = acct.borrow<&EverSinceNFT.NFTMinter>(from: EverSinceNFT.MinterStoragePath)
            ?? panic("could not borrow minter reference")

        let recipient = getAccount(receiver)
        let receiverRef = recipient.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not borrow a reference to the receiver's collection")

        var i = 0
        while i < nums.length {
            var j = 0
            while j < nums[i]{
                let ids = minterRef.GetExperienceIds(sku:sku[i])
                let r = unsafeRandom() % UInt64(ids.length)
                var transfer_target_id = ids[r] as UInt64
                var transferToken <- collectionRef.withdraw(withdrawID: transfer_target_id)
                receiverRef.deposit(token: <-transferToken)
                minterRef.removeExperienceIds(sku:sku[i], id:transfer_target_id)
                j = j + 1
            }
            i = i+1
        }
    }

    execute {

    }
}
 