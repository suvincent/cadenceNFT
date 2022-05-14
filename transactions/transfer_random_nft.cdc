// Transfer

import ExampleNFT from 0xf8d6e0586b0a20c7

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction (receiver: Address){

    // The field that will hold the NFT as it is being
    // transferred to the other account
    let transferToken: @ExampleNFT.NFT
    let transferMeta: { String : String }
    prepare(acct: AuthAccount) {

        // Borrow a reference from the stored collection
        let collectionRef = acct.borrow<&ExampleNFT.Collection>(from: ExampleNFT.CollectionStoragePath)
            ?? panic("Could not borrow a reference to the owner's collection")

        let bonus_types = 4 as UInt64
        let r = unsafeRandom() % bonus_types  
        let ids = collectionRef.getIDs()       
        var transfer_target_id = 0 as UInt64
        var find = false;
        for id in ids {
            // if this user's NFT is specific type(match bonus_types)
            if (id % bonus_types == r && !find) {
                transfer_target_id = id
                find = true
            }
        }

        // Call the withdraw function on the sender's Collection
        // to move the NFT out of the collection
        self.transferMeta = collectionRef.getMetadata(id: 1)
        self.transferToken <- collectionRef.withdraw(withdrawID: 1)
        
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
        
        receiverRef.deposit(token: <-self.transferToken, metadata: self.transferMeta)

        log("NFT ID 1 transferred from account 2 to account 1")
    }
}
 