import Beam from "../contracts/Beam.cdc"

pub fun main(address: Address): Bool {

    return getAccount(address)
        .getCapability<&{Beam.BeamCollectionPublic}>(Beam.CollectionPublicPath)
        .check()
}