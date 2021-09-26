import Crave from "../contracts/Crave.cdc"

// This is the script to get a list of all the NFTs an account owns
// Just change the argument to `getAccount` to whatever account you want
// and as long as they have a published Collection receiver, you can see
// the Collectibles they own.

// Parameters:
//
// account: The Flow Address of the account whose Collectible data needs to be read

// Returns: [Crave.NFT]
// list of all NFTs an account owns

pub fun main(account: Address, collectibleID: UInt32, serialNumber: UInt32): Crave.CollectibleData? {

    let acct = getAccount(account)

    let collectionRef = acct.getCapability(Crave.CollectionPublicPath)
        .borrow<&{Crave.CraveCollectionPublic}>()!

    for id in collectionRef.getIDs() {

        let token = collectionRef.borrowCollectible(id: id)
        ?? panic("Could not borrow a reference to the specified Collectible")

        let data = token.data

        if (collectibleID == data.collectibleItemID && serialNumber == data.serialNumber){

            return data
        }
    }

    return nil
}