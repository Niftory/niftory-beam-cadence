import Beam from "../../contracts/Beam.cdc"

// This transaction is for an Admin to start a new Beam series

transaction (name: String?, identityURL: String?) {

    // Local variable for the Beam Admin object
    let adminRef: &Beam.Admin
    let currentSeriesID: UInt32

    prepare(acct: AuthAccount) {

        // borrow a reference to the Admin resource in storage
        self.adminRef = acct.borrow<&Beam.Admin>(from: Beam.AdminStoragePath)
            ?? panic("No admin resource in storage")

        self.currentSeriesID = Beam.currentSeriesID
    }

    execute {
        
        // Create the new series
        self.adminRef.startNewSeries(name: name, identityURL: identityURL)
    }
}