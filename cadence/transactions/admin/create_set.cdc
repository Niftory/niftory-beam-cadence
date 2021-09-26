import Beam from "../../contracts/Beam.cdc"

// This transaction is for the admin to create a new set resource
// and store it in the top shot smart contract

// Parameters:
//
// setName: the name of a new Set to be created

transaction(setName: String, setIdentityURL: String?, description: String?) {
    
    // Local variable for the Admin object
    let adminRef: &Beam.Admin
    let currSetID: UInt32

    prepare(acct: AuthAccount) {

        // borrow a reference to the Admin resource in storage
        self.adminRef = acct.borrow<&Beam.Admin>(from: Beam.AdminStoragePath)
            ?? panic("Could not borrow a reference to the Admin resource")
        self.currSetID = Beam.nextSetID;
    }

    execute {
        
        // Create a set with the specified name
        self.adminRef.createSet(name: setName, setIdentityURL: setIdentityURL, description: description)
    }

    post {
        Beam.SetData(setID: self.currSetID).name == setName:
          "Could not find the specified set"
    }
}