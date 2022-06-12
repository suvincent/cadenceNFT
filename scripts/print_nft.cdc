// Print All NFTs

<<<<<<< HEAD
import EverSinceNFT from 0xf8d6e0586b0a20c7
=======
import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
import MetadataViews from 0x631e88ae7f1d7c20
>>>>>>> 2d46cf9f2ad38e923dc5e2fe36ffe48c2abf6b0a

// Print the NFTs owned by accounts 0x01 and 0x02.
pub fun main(receiver: Address,transfer: Address,):[AnyStruct] {

    // Get the public account object for account 0x02
    // let nftOwner = getAccount(0xf5306b79c7965708)
    var r : [AnyStruct] = []

    // Find the public Receiver capability for their Collections
    let OwnerCapability = nftOwner.getCapability(EverSinceNFT.CollectionPublicPath)
    let ReceiverCapability = nftReceiver.getCapability(EverSinceNFT.CollectionPublicPath)

    // borrow references from the capabilities
    let nftOwnerRef = OwnerCapability.borrow<&{EverSinceNFT.NFTReceiver}>()
        ?? panic("Could not borrow nftOwner reference")
    let nftReceiverRef = ReceiverCapability.borrow<&{EverSinceNFT.NFTReceiver}>()
        ?? panic("Could not borrow nftReceiver reference")

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
 
