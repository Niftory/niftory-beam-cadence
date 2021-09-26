import Beam from "../contracts/Beam.cdc"

// This script reads the current Series from the Beam contract and 
// returns that number to the caller

// Returns: Beam.Series
// The Current Series struct in the Beam contract

pub fun main(): Beam.CurrSeriesData {
    let currSeries = Beam.CurrSeriesData()
    return currSeries
}