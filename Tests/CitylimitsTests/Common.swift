import Testing
@testable import Citylimits

let buildableTypes = TileType.allCases.filter { $0 != .empty }

/// Default setup
/// ----------
/// Width: 4
/// Height: 4
/// Level: easy (20,000)
/// Seed: 42
func testCity(height: Int = 4,
              width: Int = 4,
              level: GameLevel = .easy,
              seed: UInt64 = 42) -> City {
    return City(
        width: height,
        height: width,
        level: level,
        rng: SeededGenerator(seed: seed))
}
