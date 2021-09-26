import Crave from "../../contracts/Crave.cdc"

// This transaction creates a new Collectible Item struct 
// and stores it in the Crave smart contract

// Parameters:
//
// metadata: A dictionary of all the Collectible metadata associated
// name: <name of the NFT>
// description: <description of the NFT>
// mediaUrl: <full url of the NFT>
// mediaType: <image/png, video/mp4... etc>
// externalLink: <full url of the NFT shown on your website>

transaction(name: String, description: String, mediaUrl: String, mediaType: String, externalLink: String, featuredArtists: [String]) {

    // Local variable for the Crave Admin object
    let adminRef: &Crave.Admin
    let currCollectibleItemID: UInt32
    let metadata: {String: String}

    prepare(acct: AuthAccount) {

        // borrow a reference to the admin resource
        self.currCollectibleItemID = Crave.nextCollectibleItemID;
        self.adminRef = acct.borrow<&Crave.Admin>(from: Crave.AdminStoragePath)
            ?? panic("No admin resource in storage")
        self.metadata = {
            "name": name,
            "description": description,
            "mediaUrl": mediaUrl,
            "mediaType": mediaType,
            "externalLink": externalLink
        }
    }

    execute {
       // Create a play with the specified metadata
        self.adminRef.createCollectibleItem(metadata: self.metadata, featuredArtists: featuredArtists)
    }

    post {
        
        Crave.getCollectibleItemMetaData(collectibleItemID: self.currCollectibleItemID) != nil:
            "collectibleItemID doesnt exist"
    }
}