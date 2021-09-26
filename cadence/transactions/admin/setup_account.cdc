import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import Crave from "../../contracts/Crave.cdc"

// This transaction sets up an account to collect Crave Collectibles
// by storing an empty Crave collectible collection and creating
// a public capability for it

transaction {

    prepare(acct: AuthAccount) {

        // First, check to see if a Crave collectible collection already exists
        if acct.borrow<&Crave.Collection>(from: Crave.CollectionStoragePath) == nil {

            // create a new Crave Collection
            let collection <- Crave.createEmptyCollection() as! @Crave.Collection

            // Put the new Collection in storage
            acct.save(<-collection, to: Crave.CollectionStoragePath)

            // create a public capability for the collection
            acct.link<&{Crave.CraveCollectionPublic}>(Crave.CollectionPublicPath, target: Crave.CollectionStoragePath)

        }
    }
}