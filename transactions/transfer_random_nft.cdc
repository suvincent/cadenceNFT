// Transfer

import ExampleNFT from 0xf8d6e0586b0a20c7

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction (receiver: Address){

    // The field that will hold the NFT as it is being
    // transferred to the other account
    let transferToken: @ExampleNFT.NFT
    // let transferMeta: { String : String }
    prepare(acct: AuthAccount) {

        // Borrow a reference from the stored collection
        let collectionRef = acct.borrow<&ExampleNFT.Collection>(from: ExampleNFT.CollectionStoragePath)
            ?? panic("Could not borrow a reference to the owner's collection")

        let ids = collectionRef.getIDs()  
        let r = unsafeRandom() % UInt64(ids.length)
        var transfer_target_id = ids[r] as UInt64
        // assert(!find, message: "there is no enough NFT")
        // Call the withdraw function on the sender's Collection
        // to move the NFT out of the collection
        // self.transferMeta = collectionRef.getMetadata(id: transfer_target_id)
        self.transferToken <- collectionRef.withdraw(withdrawID: transfer_target_id)
        
    }

    execute {
        // Get the recipient's public account object
        let recipient = getAccount(receiver)

        // Get the Collection reference for the receiver
        // getting the public capability and borrowing a reference from it
        let receiverRef = recipient.getCapability<&{ExampleNFT.NFTReceiver}>(ExampleNFT.CollectionPublicPath)
            .borrow()
            ?? panic("Could not borrow receiver reference")
        
        // Deposit the NFT in the receivers collection
        
        receiverRef.deposit(token: <-self.transferToken)

        log("NFT ID 1 transferred from account 2 to account 1")
    }
}
 