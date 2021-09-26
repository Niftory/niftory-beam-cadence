import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import Beam from "../../contracts/Beam.cdc"

// This transaction sets up an account to collect Beam Collectibles
// by storing an empty Beam collectible collection and creating
// a public capability for it

transaction {

    prepare(acct: AuthAccount) {

        // First, check to see if a Beam collectible collection already exists
        if acct.borrow<&Beam.Collection>(from: Beam.CollectionStoragePath) == nil {

            // create a new Beam Collection
            let collection <- Beam.createEmptyCollection() as! @Beam.Collection

            // Put the new Collection in storage
            acct.save(<-collection, to: Beam.CollectionStoragePath)

            // create a public capability for the collection
            acct.link<&{Beam.BeamCollectionPublic}>(Beam.CollectionPublicPath, target: Beam.CollectionStoragePath)

        }
    }
}