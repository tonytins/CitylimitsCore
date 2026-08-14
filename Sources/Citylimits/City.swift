import Foundation

public protocol Buildable {
    mutating func build(at point: Point, type: TileType) -> Bool
}

public protocol Bulldozable {
    mutating func bulldoze(at point: Point) -> Bool
}

public protocol Resettable {
    mutating func reset()
}

public protocol Taxable {
    var treasury: Int { get set }
    func collectTaxes() -> Int
}

public protocol Updatable {
    mutating func update(dt: DeltaTime)
}

public enum TaxModel {
    case perResident(numerator: Int, denominator: Int)
    case baseWithResidentBonus(base: Int, bonusPerResident: Int)
    case none
}

// Base
let trainStationTaxBase = 3
let schoolTaxBase = 1
let postOfficeTaxBase = 2
let emsTaxBase = 3

// Bonus
let trainStationTaxBonus = 4
let schoolTaxBonus = 3
let postOfficeTaxBonus = 5
let emsTaxRonus = 3


public struct City: Updatable, Resettable, Buildable, Bulldozable {
    
    let bulldozeCost = 10
        
    let randomDisasterChance = 0.02
    let trainStationTaxRevenue = 50
    
    let minTreasury = Int.min / 2
    let maxTreasury = Int.max / 2
        
    var storedTreasury: Int
    
    var accumulatedTime: DeltaTime
    var rng: any RandomNumberGenerator
    
    public var map: Map
    
    public var visualGlyphsEnabled: Bool
    
    public let startingFunds: Int
    public var population: Int
    public var taxIncomeLastTick: Int
    public var maintenanceLastTick: Int

}

// MARK: - Public API

public extension City {
    
    init(
        width: Int,
        height: Int,
        startingFunds: Int = 10_000,
        visualGlyphsEnabled: Bool = false,
        rng: any RandomNumberGenerator = SystemRandomNumberGenerator()
    ) {
        self.map = Map(width: width, height: height)
        self.storedTreasury = startingFunds
        self.visualGlyphsEnabled = visualGlyphsEnabled
        self.startingFunds = startingFunds
        self.population = 0
        self.taxIncomeLastTick = 0
        self.maintenanceLastTick = 0
        self.accumulatedTime = 0
        self.rng = rng
    }
    
    var treasurey: Int {
        get { storedTreasury }
        set { storedTreasury = min(max(newValue, minTreasury), maxTreasury) }
    }
    
    mutating func update(dt: DeltaTime) {
        accumulatedTime += dt
        let tickInterval: DeltaTime = 1.0
        
        while accumulatedTime >= tickInterval {
            accumulatedTime -= tickInterval
            // TODO: the entire Micropolis game loop xD
        }
    }
    
    mutating func reset() {
        // TODO: clear map and any disaster
        treasurey = startingFunds
        population = 0
        taxIncomeLastTick = 0
        maintenanceLastTick = 0
    }
    
    mutating func build(at point: Point, type: TileType) -> Bool {
        // TODO: map.valid() and map[point].type
        guard treasurey >= type.buildCost else {
            return false
        }
        
        treasurey -= type.buildCost
        var tile = Tile(type: type)
        tile.population = Int
            .random(in: type.startingPopulationRange, using: &rng)
        return true
    }
    
    mutating func bulldoze(at point: Point) -> Bool {
        guard treasurey >= bulldozeCost else {
            return false
        }
        
        treasurey -= bulldozeCost
        return true
    }
}
