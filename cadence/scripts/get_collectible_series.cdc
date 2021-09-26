import Beam from "../contracts/Beam.cdc"

// This script gets the Series associated with a Collectible
// in a collection by getting a reference to the Collectible
// and then looking up its series

// Parameters:
//
// account: The Flow Address of the account whose Collectible data needs to be read
// id: The unique ID for the Collectible whose data needs to be read

// Returns: Beam.Series
// The Series associated with a Collectible with a specified ID

pub fun main(account: Address, id: UInt64): Beam.Series {

    let collectionRef = getAccount(account).getCapability(Beam.CollectionPublicPath)
        .borrow<&{Beam.BeamCollectionPublic}>()
        ?? panic("Could not get public Beam collection reference")

    let token = collectionRef.borrowCollectible(id: id)
        ?? panic("Could not borrow a reference to the specified Collectible")

    let data = token.data

    return Beam.SetData(setID: data.setID).series
}