// Transfer

import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
// import NonFungibleToken from "../cadence/contracts/NonFungibleToken.cdc"

import NonFungibleToken from 0x1d7e57aa55817448

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction (receiver: Address, num: Int, experience:String){

    // let transferMeta: { String : String }
    prepare(acct: AuthAccount) {

        // Borrow a capability for the NFTMinter in storage
        let minterRef = acct.borrow<&EverSinceNFT.NFTMinter>(from: EverSinceNFT.MinterStoragePath)
            ?? panic("could not borrow minter reference")
            minterRef.removeExperienceIds(sku:experience, id:1)
            minterRef.removeExperienceIds(sku:experience, id:5)
    }

    execute {

    }
}
 