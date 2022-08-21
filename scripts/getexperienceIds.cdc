// Print 0x02 NFTs
import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x1d7e57aa55817448
import MetadataViews from 0x1d7e57aa55817448

pub fun main(experience: String, receiver: Address):[AnyStruct]{
    let nftOwner = getAccount(receiver)

    // borrow a reference from the capability
    let nftOwnerRef = nftOwner.getCapability(EverSinceNFT.MinterPublicPath)
            .borrow<&{EverSinceNFT.EverSinceNFTMinterPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")
    return nftOwnerRef.GetExperienceIds(sku:experience);      
}