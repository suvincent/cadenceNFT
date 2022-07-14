import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
// import NonFungibleToken from "../cadence/contracts/NonFungibleToken.cdc"


transaction (nft_id: UInt64, receiver: Address){

    // The reference to the collection that will be receiving the NFT
    // let receiverRef: &{EverSinceNFT.EverSinceNFTCollectionPublic}
    prepare(acct: AuthAccount) {
        // Get the recipient's public account object
        let recipient = getAccount(receiver)

        // Get the Collection reference for the receiver
        // getting the public capability and borrowing a reference from it
        let receiverRef = recipient.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{EverSinceNFT.EverSinceNFTCollectionPublic}>()
            ?? panic("Could not borrow a reference to the receiver's collection")

        let nft = receiverRef.borrowEverSinceNFT(id: nft_id)!
        nft.useBonus(minter: acct)
    }

    execute {

        

    }
}
 