import Testing
@testable import Citylimits

public struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64
    
    public init(seed: UInt64) {
        self.state = seed
    }
    
    public mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}

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
