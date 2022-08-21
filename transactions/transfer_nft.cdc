// Transfer

import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x1d7e57aa55817448

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction (receiver: Address, nft_id: UInt64){

    // The field that will hold the NFT as it is being
    // transferred to the other account
    let transferToken: @NonFungibleToken.NFT
    // let transferMeta: { String : String }
    prepare(acct: AuthAccount) {

        // Borrow a reference from the stored collection
        let collectionRef = acct.borrow<&EverSinceNFT.Collection>(from: EverSinceNFT.CollectionStoragePath)
            ?? panic("Could not borrow a reference to the owner's collection")

        // Call the withdraw function on the sender's Collection
        // to move the NFT out of the collection
        // self.transferMeta = collectionRef.getMetadata(id: nft_id)
        self.transferToken <- collectionRef.withdraw(withdrawID: nft_id)
    }

    execute {
        // Get the recipient's public account object
        let recipient = getAccount(receiver)

        // Get the Collection reference for the receiver
        // getting the public capability and borrowing a reference from it
        let receiverRef = recipient.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not borrow a reference to the receiver's collection")
        // Deposit the NFT in the receivers collection
        
        receiverRef.deposit(token: <-self.transferToken)

        log("NFT ID 1 transferred from nftOwner to nftReceiver")
    }
}
 