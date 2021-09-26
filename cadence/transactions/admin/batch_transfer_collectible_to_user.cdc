import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"
import Beam from "../../contracts/Beam.cdc"

// This transaction transfers a number of Collectibles to a recipient

// Parameters
//
// recipientAddress: the Flow address who will receive the NFTs
// collectibleIDs: an array of Collectible IDs of NFTs that recipient will receive

transaction(recipientAddress: Address, collectibleIDs: [UInt64]) {

    let transferTokens: @NonFungibleToken.Collection
    
    prepare(acct: AuthAccount) {

        self.transferTokens <- acct.borrow<&Beam.Collection>(from: Beam.CollectionStoragePath)!.batchWithdraw(ids: collectibleIDs)
    }

    execute {
        
        // get the recipient's public account object
        let recipient = getAccount(recipientAddress)

        // get the Collection reference for the receiver
        let receiverRef = recipient.getCapability(Beam.CollectionPublicPath).borrow<&{Beam.BeamCollectionPublic}>()
            ?? panic("Could not borrow a reference to the recipients Beam receiver")

        // deposit the NFT in the receivers collection
        receiverRef.batchDeposit(tokens: <-self.transferTokens)
    }
}