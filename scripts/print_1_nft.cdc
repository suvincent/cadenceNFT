// Print 0x02 NFTs

import ExampleNFT from "../cadence/contracts/ExampleNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
import MetadataViews from 0x631e88ae7f1d7c20

// Print the NFTs owned by account 0x02.
pub fun main():[AnyStruct]{
    // Get the public account object for account 0x02
    // let nftOwner = getAccount(0xf5306b79c7965708)
    let nftOwner = getAccount(0xe4cfd0599f12598c)

    // borrow a reference from the capability
    let nftOwnerRef = nftOwner.getCapability(ExampleNFT.CollectionPublicPath)
            .borrow<&{ExampleNFT.ExampleNFTCollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")

    // Log the NFTs that they own as an array of IDs
    log("nftOwner NFTs")
    var r : [AnyStruct] = []

    let ids = nftOwnerRef.getIDs()
    for id in ids {
        let nft = nftOwnerRef.borrowExampleNFT(id: id)!
        let view = nft.resolveView(Type<MetadataViews.Display>())!
        r.append(view)
    }
    return r
}
 