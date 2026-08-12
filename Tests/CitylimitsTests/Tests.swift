import Testing
@testable import Citylimits

let buildableTypes = TileType.allCases.filter { $0 != .empty }

let defaultStartingFunds = 10_000
let seed: UInt64 = 42

@Suite("Buildings")
struct <#name#> {
    @Test("Build every buildable type", arguments: buildableTypes) func buildEachTileType(type: TileType) {
        let city = City(
            width: 4,
            height: 4,
            storedTreasury: defaultStartingFunds,
            rng: SeededGenerator(seed: seed))
        
        let point = Point(x: 1, y: 1)
        
    }
}
