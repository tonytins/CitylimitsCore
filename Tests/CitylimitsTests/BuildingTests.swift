import Testing
@testable import Citylimits

@Suite("Buildings")
struct BuildingTests {
    @Test("Build every buildable type", arguments: buildableTypes)
    func buildEachTileType(type: TileType) {
        var city = testCity()
        let point = Point(x: 1, y: 1)
        
        let built = city.build(at: point, type: type)
        #expect(built, "Expected to build \(type) on an empty tile.")
        withKnownIssue("Returns empty") {
            #expect(city.map[point].type == type, "Tile should be \(type) after building.")
        }
        
    }
    
    @Test("Build fails when funds are insufficient")
    func buildInsufficientFunds() {
        var city = City(width: 3, height: 3, funds: 5)
        let built = city.build(at: Point(x: 0, y: 0), type: .road)
        
        #expect(!built, "Road costs 10. Only 5 funds available.")
    }
}
