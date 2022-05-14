// Print 0x02 NFTs

import ExampleNFT from 0xf8d6e0586b0a20c7

// Print the NFTs owned by account 0x02.
pub fun main() {
    // Get the public account object for account 0x02
    let nftOwner = getAccount(0xf8d6e0586b0a20c7)

    // Find the public Receiver capability for their Collection
    let capability = nftOwner.getCapability<&{ExampleNFT.NFTReceiver}>(ExampleNFT.CollectionPublicPath)

    // borrow a reference from the capability
    let nftOwnerRef = capability.borrow()
        ?? panic("Could not borrow the receiver reference")

    // Log the NFTs that they own as an array of IDs
    log("nftOwner NFTs")
    log(nftOwnerRef.getIDs())
    for id in nftOwnerRef.getIDs() {
        log(nftOwnerRef.getMetadata(id: id))
    }
    // log(nftOwnerRef.getMetadata(id: 1))
}
 