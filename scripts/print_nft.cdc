// Print All NFTs

import ExampleNFT from 0xf8d6e0586b0a20c7

// Print the NFTs owned by accounts 0x01 and 0x02.
pub fun main() {

    // Get both public account objects
    let nftOwner = getAccount(0xf8d6e0586b0a20c7)
	let nftReceiver = getAccount(0x01cf0e2f2f715450)

    // Find the public Receiver capability for their Collections
    let OwnerCapability = nftOwner.getCapability(ExampleNFT.CollectionPublicPath)
    let ReceiverCapability = nftReceiver.getCapability(ExampleNFT.CollectionPublicPath)

    // borrow references from the capabilities
    let nftOwnerRef = OwnerCapability.borrow<&{ExampleNFT.NFTReceiver}>()
        ?? panic("Could not borrow nftOwner reference")
    let nftReceiverRef = ReceiverCapability.borrow<&{ExampleNFT.NFTReceiver}>()
        ?? panic("Could not borrow nftReceiver reference")

    // Print both collections as arrays of IDs
    log("nftOwner NFTs")
    log(nftOwnerRef.getIDs())
    for id in nftOwnerRef.getIDs() {
        log(nftOwnerRef.getMetadata(id: id))
    }

    log("nftReceiver NFTs")
    log(nftReceiverRef.getIDs())
    for id in nftReceiverRef.getIDs() {
        log(nftReceiverRef.getMetadata(id: id))
    }
}
 