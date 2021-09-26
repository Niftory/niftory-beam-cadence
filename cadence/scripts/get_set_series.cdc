import Beam from "../contracts/Beam.cdc"

// This script reads the Series of the specified set and returns it

// Parameters:
//
// setID: The unique ID for the set whose data needs to be read

// Returns: Beam.Series
// The Series struct

pub fun main(setID: UInt32): Beam.Series {
    return Beam.SetData(setID: setID).series
}