// Print 0x02 NFTs
import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
// import NonFungibleToken from "../cadence/contracts/NonFungibleToken.cdc"
// import MetadataViews from "../cadence/contracts/MetadataViews.cdc"

import NonFungibleToken from 0x631e88ae7f1d7c20
import MetadataViews from 0x631e88ae7f1d7c20

pub fun main(receiver: Address, id: UInt64):{String : String}{
    let nftOwner = getAccount(receiver)

    // borrow a reference from the capability
    let nftOwnerRef = nftOwner.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{EverSinceNFT.EverSinceNFTCollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")

    // Log the NFTs that they own as an array of IDs
    log("nftOwner NFTs")
    var r : [AnyStruct] = []

    let nft = nftOwnerRef.borrowEverSinceNFT(id: id)!
    return nft.getMetadata()
}