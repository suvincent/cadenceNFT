<<<<<<< HEAD
import EverSinceNFT from 0xf8d6e0586b0a20c7
transaction (nft_id: UInt64){

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{EverSinceNFT.NFTReceiver}
    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability<&{EverSinceNFT.NFTReceiver}>(EverSinceNFT.CollectionPublicPath)
            .borrow()
            ?? panic("Could not borrow receiver reference")
=======
import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction (nft_id: UInt64){

    // The reference to the collection that will be receiving the NFT
    let receiverRef: &{EverSinceNFT.EverSinceNFTCollectionPublic}
    prepare(acct: AuthAccount) {
        // Get the owner's collection capability and borrow a reference
        self.receiverRef = acct.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{EverSinceNFT.EverSinceNFTCollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")
>>>>>>> 2d46cf9f2ad38e923dc5e2fe36ffe48c2abf6b0a

    }

    execute {

        let nft = self.receiverRef.borrowEverSinceNFT(id: nft_id)!
        nft.useBonus()

    }
}
 