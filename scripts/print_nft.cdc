// Print All NFTs

import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x1d7e57aa55817448
import MetadataViews from 0x1d7e57aa55817448

// Print the NFTs owned by accounts 0x01 and 0x02.
pub fun main(receiver: Address,transfer: Address,):[AnyStruct] {

    // Get the public account object for account 0x02
    // let nftOwner = getAccount(0xf5306b79c7965708)
    var r : [AnyStruct] = []

    let addrArray = [receiver,transfer]
    for index, element in addrArray {
        let nftOwner = getAccount(element)

        // borrow a reference from the capability
        let nftOwnerRef = nftOwner.getCapability(EverSinceNFT.CollectionPublicPath)
                .borrow<&{EverSinceNFT.EverSinceNFTCollectionPublic}>()
                ?? panic("Could not get receiver reference to the NFT Collection")

        // Log the NFTs that they own as an array of IDs
        log("nftOwner NFTs")
        let ids = nftOwnerRef.getIDs()
        for id in ids {
            let nft = nftOwnerRef.borrowEverSinceNFT(id: id)!
            let view = nft.resolveView(Type<MetadataViews.Display>())!
            r.append(view)
        }
        
    }
    
    return r
}
 