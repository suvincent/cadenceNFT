// Print 0x02 NFTs
import EverSinceNFT from "../cadence/contracts/EverSinceNFT.cdc"
import NonFungibleToken from 0x631e88ae7f1d7c20
import MetadataViews from 0x631e88ae7f1d7c20

pub fun main(experience: String, receiver: Address):[AnyStruct]{
    let nftOwner = getAccount(receiver)

    // borrow a reference from the capability
    let nftOwnerRef = nftOwner.getCapability(EverSinceNFT.MinterPublicPath)
            .borrow<&{EverSinceNFT.EverSinceNFTMinterPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")
    return nftOwnerRef.GetExperienceIds(experience:experience);      
}