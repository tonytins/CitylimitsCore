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

public struct City: Updatable, Resettable {
   
    public static let bulldozeCost = 10
    public static let randomDisasterChance = 0.02
    public static let trainStationTaxRevenue = 50
    
    public static let minTreasury = Int.min / 2
    public static let maxTreasury = Int.max / 2
    
    public var map: Map
    
    var storedTreasury: Int
    
    public var visualGlyphsEnabled: Bool
    
    public let startingFunds: Int
    public var population: Int
    public var taxIncomeLastTick: Int
    public var maintenanceLastTick: Int
    
    var accumulatedTime: DeltaTime
    var rng: any RandomNumberGenerator
    
    public init(
        width: Int,
        height: Int,
        storedTreasury: Int,
        visualGlyphsEnabled: Bool,
        startingFunds: Int = 10_000,
        rng: any RandomNumberGenerator = SystemRandomNumberGenerator()
    ) {
        self.map = Map(width: width, height: height)
        self.storedTreasury = storedTreasury
        self.visualGlyphsEnabled = visualGlyphsEnabled
        self.startingFunds = startingFunds
        self.population = 0
        self.taxIncomeLastTick = 0
        self.maintenanceLastTick = 0
        self.accumulatedTime = 0
        self.rng = rng
    }
    
    public var treasurey: Int {
        get { storedTreasury }
        set { storedTreasury = min(max(newValue, City.minTreasury), City.maxTreasury) }
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
    
}
