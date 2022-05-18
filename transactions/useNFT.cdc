import ExampleNFT from "../cadence/contracts/ExampleNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction (nft_id: UInt64){

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{NonFungibleToken.CollectionPublic}
    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability(ExampleNFT.CollectionPublicPath)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")

    }

    execute {

        self.receiverRef.useNFT(id: nft_id)

        //log msg
        let log1 = "NFT".concat(nft_id.toString())
        let log2 = log1.concat(" be used");
        log(log2)

    }
}
 