// Print 0x02 NFTs
import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
import MetadataViews from 0x631e88ae7f1d7c20

pub fun main(receiver: Address):[AnyStruct]{
    let nftOwner = getAccount(receiver)

    // borrow a reference from the capability
    let nftOwnerRef = nftOwner.getCapability(EverSinceNFT.CollectionPublicPath)
            .borrow<&{EverSinceNFT.EverSinceNFTCollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")

    // Log the NFTs that they own as an array of IDs
    log("nftOwner NFTs")
    var r : [AnyStruct] = []

    let ids = nftOwnerRef.getIDs()
    for id in ids {
        let nft = nftOwnerRef.borrowEverSinceNFT(id: id)!
        let view = nft.resolveView(Type<MetadataViews.Display>())!
        r.append(view)
    }
    return r
}