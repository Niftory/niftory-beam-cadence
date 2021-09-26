import Crave from "../contracts/Crave.cdc"

// This script reads the current Series from the Crave contract and 
// returns that number to the caller

// Returns: Crave.Series
// The Current Series struct in the Crave contract

pub fun main(): Crave.CurrSeriesData {
    let currSeries = Crave.CurrSeriesData()
    return currSeries
}