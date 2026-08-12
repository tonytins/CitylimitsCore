import Foundation

protocol Buildable {
    mutating func build(at point: Point, type: TileType) -> Bool
}

protocol Bulldozable {
    mutating func bulldoze(at point: Point) -> Bool
}

protocol Resettable {
    mutating func reset()
}

protocol Taxable {
    var treasury: Int { get set }
    func collectTaxes() -> Int
}

protocol Updatable {
    mutating func update(dt: DeltaTime)
}

public struct City {
    
    public static let bulldozeCost = 10
    public static let randomDisasterChance = 0.02
    public static let trainStationTaxRevenue = 50
    
    public static let minTreasury = Int.min / 2
    public static let maxTreasury = Int.max / 2
    
}
