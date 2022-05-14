import ExampleNFT from 0xf8d6e0586b0a20c7
transaction (nft_id: UInt64){

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{ExampleNFT.NFTReceiver}
    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability<&{ExampleNFT.NFTReceiver}>(ExampleNFT.CollectionPublicPath)
            .borrow()
            ?? panic("Could not borrow receiver reference")

    }

    execute {

        self.receiverRef.useNFT(id: nft_id)

        //log msg
        let log1 = "NFT".concat(nft_id.toString())
        let log2 = log1.concat(" be used");
        log(log2)

    }
}
 