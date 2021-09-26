import Crave from "../contracts/Crave.cdc"

pub fun main(address: Address): Bool {

    return getAccount(address)
        .getCapability<&{Crave.CraveCollectionPublic}>(Crave.CollectionPublicPath)
        .check()
}