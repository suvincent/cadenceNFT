// Print 0x02 NFTs

import EverSinceNFT from 0xf8d6e0586b0a20c7

// Print the NFTs owned by account 0x02.
pub fun main() {
    // Get the public account object for account 0x02
    let nftOwner = getAccount(0xf8d6e0586b0a20c7)

    // Find the public Receiver capability for their Collection
    let capability = nftOwner.getCapability<&{EverSinceNFT.NFTReceiver}>(EverSinceNFT.CollectionPublicPath)

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
 
