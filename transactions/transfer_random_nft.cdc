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
        self.transferMeta = collectionRef.getMetadata(id: 1)
        self.transferToken <- collectionRef.withdraw(withdrawID: 1)
        // Call the withdraw function on the sender's Collection
        // to move the NFT out of the collection
        let bonus_types = 4 as UInt64
        let r = unsafeRandom() % bonus_types
        let ids = collectionRef.getIDs()
        var transfer_target_id = 0 as UInt64
        for id in ids {
            if id % bonus_types == r && id > 1 {
                transfer_target_id = id
                break;
            }
        }
        // var i = 0;
        // while i < ids.length {
        //     i = i + 1
        //     if ids[i] % bonus_types == r {
        //         transfer_target_id = ids[i]
        //         break;
        //     }
        // }
        log(transfer_target_id)
        assert(transfer_target_id > 0, message: "id must grater than zeros")
        log(transfer_target_id)
        self.transferToken <- collectionRef.withdraw(withdrawID: transfer_target_id)
        self.transferMeta = collectionRef.getMetadata(id: transfer_target_id)
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
 