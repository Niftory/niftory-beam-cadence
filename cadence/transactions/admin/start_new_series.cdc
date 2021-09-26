import Crave from "../../contracts/Crave.cdc"

// This transaction is for an Admin to start a new Crave series

transaction (name: String?, identityURL: String?) {

    // Local variable for the Crave Admin object
    let adminRef: &Crave.Admin
    let currentSeriesID: UInt32

    prepare(acct: AuthAccount) {

        // borrow a reference to the Admin resource in storage
        self.adminRef = acct.borrow<&Crave.Admin>(from: Crave.AdminStoragePath)
            ?? panic("No admin resource in storage")

        self.currentSeriesID = Crave.currentSeriesID
    }

    execute {
        
        // Create the new series
        self.adminRef.startNewSeries(name: name, identityURL: identityURL)
    }
}