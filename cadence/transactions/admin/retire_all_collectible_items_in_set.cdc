import Beam from "../../contracts/Beam.cdc"

// This transaction is for retiring all collectible items from a set, which
// makes it so that collectibles can no longer be minted
// from all the editions with that set

// Parameters:
//
// setID: the ID of the set to be retired entirely

transaction(setID: UInt32) {
    let adminRef: &Beam.Admin

    prepare(acct: AuthAccount) {

        // borrow a reference to the Admin resource in storage
        self.adminRef = acct.borrow<&Beam.Admin>(from: Beam.AdminStoragePath)
            ?? panic("No admin resource in storage")
    }

    execute {
        // borrow a reference to the specified set
        let setRef = self.adminRef.borrowSet(setID: setID)

        // retire all the collectible items
        setRef.retireAll()
    }
}
