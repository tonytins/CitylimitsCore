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
    
    public internal(set) var map: Map
    
    public var emojisEnabled: Bool
    
    public let startingFunds: Int
    public private(set) var population: Int
    
    public private(set) var taxIncomeLastCollection: Int
    public private(set) var maintenanceLastCollection: Int
    public private(set) var didCollect: Bool
    
    public init(
        width: Int,
        height: Int,
        level: GameLevel = .easy,
        emojisEnabled: Bool = false,
        rng: any RandomNumberGenerator = SystemRandomNumberGenerator()
    ) {
        self.init(
            width: width,
            height: height,
            funds: level.startingFunds,
            emojisEnabled: emojisEnabled,
            rng: rng
        )
    }
    
    public init(
        width: Int,
        height: Int,
        funds: Int,
        emojisEnabled: Bool = false,
        rng: any RandomNumberGenerator = SystemRandomNumberGenerator()
    ) {
        self.map = Map(width: width, height: height)
        self.storedTreasury = funds
        self.emojisEnabled = emojisEnabled
        self.startingFunds = funds
        self.population = 0
        self.taxIncomeLastCollection = 0
        self.maintenanceLastCollection = 0
        self.accumulatedTime = 0
        self.rng = rng
        self.didCollect = false
    }

}

// MARK: - Public API

public extension City {
        
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
        taxIncomeLastCollection = 0
        maintenanceLastCollection = 0
        didCollect = false
    }
    
    mutating func build(at point: Point, type: TileType) -> Bool {
        guard map.valid(point: point) else {
            return false
        }
        guard map[point].type == .empty else {
            return false
        }
        guard treasurey >= type.buildCost else {
            return false
        }
        
        treasurey -= type.buildCost
        var tile = Tile(type: type)
        tile.population = Int
            .random(in: type.startingPopulationRange, using: &rng)
        return true
    }
    
    func isValid(point: Point) -> Bool {
        map.valid(point: point)
    }
    
    mutating func bulldoze(at point: Point) -> Bool {
        guard treasurey >= bulldozeCost else {
            return false
        }
        
        treasurey -= bulldozeCost
        return true
    }
}
