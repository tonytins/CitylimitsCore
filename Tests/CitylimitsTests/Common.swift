import Testing
@testable import Citylimits

let buildableTypes = TileType.allCases.filter { $0 != .empty }

/// Default setup
/// ----------
/// Width: 4
/// Height: 4
/// Funds: 10,000
/// Seed: 62
func testCity(height: Int = 4,
              width: Int = 4,
              funds: Int = 10_000,
              seed: UInt64 = 62) -> City {
    return City(
        width: height,
        height: width,
        startingFunds: funds,
        rng: SeededGenerator(seed: seed))
}
