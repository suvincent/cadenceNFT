import ExampleNFT from "../cadence/contracts/ExampleNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction (nft_id: UInt64){

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{ExampleNFT.ExampleNFTCollectionPublic}
    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability(ExampleNFT.CollectionPublicPath)
            .borrow<&{ExampleNFT.ExampleNFTCollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")

    }

    execute {

        let nft = self.receiverRef.borrowExampleNFT(id: nft_id)!
        nft.changeUrlAfterBonus()
        nft.useBonus()

    }
}
 