import Crave from "../contracts/Crave.cdc"

// This script reads the Series of the specified set and returns it

// Parameters:
//
// setID: The unique ID for the set whose data needs to be read

// Returns: Crave.Series
// The Series struct

pub fun main(setID: UInt32): Crave.Series {
    return Crave.SetData(setID: setID).series
}