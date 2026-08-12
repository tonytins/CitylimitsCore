import Foundation

public typealias DeltaTime = TimeInterval

public struct Point: Equatable, Hashable, Sendable {
    public var x: Int
    public var y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}


public enum TileType: String, Codable, CaseIterable, Sendable {
    case empty
    case residential
    case commercial
    case industrial
    case road
    case powerPlant
    case park
    case rail
    case trainStation
    case fire
    case rubble
    case fireStation
    case hotel
    case school
    case postOffice
    case hospital
    
    public var buildCost: Int {
        switch self {
        case .road: 10
        case .park: 50
        case .rail: 15
        case .residential: 200
        case .commercial: 300
        case .industrial: 250
        case .powerPlant: 2_000
        case .fireStation: 400
        case .trainStation: 500
        case .hotel: 350
        case .school: 300
        case .postOffice: 250
        case .hospital: 600
        case .empty, .fire, .rubble: 0
        }
    }
    
    public var maintenanceCost: Int {
        switch self {
        case .road, .rail: 1
        case .park: 2
        case .powerPlant: 50
        case .trainStation: 10
        case .hospital: 15
        case .school, .postOffice: 5
        default: 0
        }
    }
    
    /// In their default mode, these are mostly used by the save file.
    public var glyph: Character {
        switch self {
        case .empty: return "."
        case .residential: return "🏠"
        case .commercial: return "🏢"
        case .industrial: return "🏭"
        case .road: return "="
        case .powerPlant: return "⚡"
        case .park: return "🌳"
        case .rail: return "-"
        case .trainStation: return "🚉"
        case .fireStation: return "🚒"
        case .fire: return "🔥"
        case .rubble: return "🧱"
        case .hotel: return "🏨"
        case .school: return "🏫"
        case .postOffice: return "🏤"
        case .hospital: return "🏥"
        }
    }
    
    var startingPopulationRange: ClosedRange<Int> {
        switch self {
        case .residential: 0...4
        case .commercial: 0...2
        case .industrial: 0...3
        case .hotel: 0...2
        default: 0...0
        }
    }
    
    public var isZone: Bool {
        switch self {
        case .residential, .commercial, .hotel, .industrial: true
        default: false
        }
    }
    
    public var activityRequirement: ActivityRequirement? {
        switch self {
        case .residential: return .powerAndAdjacent(to: .road)
        case .commercial: return .powerAndAdjacentPopulated(.residential)
        case .industrial: return .powerOnly
        case .trainStation: return .powerAndAdjacent(to: .rail)
        case .fireStation, .hotel, .school, .postOffice, .hospital: return .powerAndAdjacent(
            to: .road)
        default: return nil
        }
    }
    
    public var taxModel: TaxModel {
        switch self {
            case .residential: return .perResident(numerator: 1, denominator: 1)
            case .commercial: return .perResident(numerator: 2, denominator: 1)
            case .industrial: return .perResident(numerator: 3, denominator: 2)
            case .hotel: return .perResident(numerator: 2, denominator: 1)
            case .trainStation: return .flat(City.trainStationTaxRevenue)
            case .school: return .flat(City.schoolTaxRevenue)
            case .postOffice: return .flat(City.postOfficeTaxRevenue)
        case .hospital, .fireStation: return .flat(City.emsTaxRevenue)
            case .empty, .road, .powerPlant, .park, .rail, .fire, .rubble: return .none
        }
    }
}

public struct Tile: Sendable {
    public var type: TileType
    public var population: Int
    public var powered: Bool
    
    public init(
        type: TileType = .empty,
        population: Int = 0,
        powered: Bool = false
    ) {
        self.type = type
        self.population = population
        self.powered = powered
    }
    
    let powerPlanetCapacity = 50
    
    let trainStationPowerDemand = 5
    
    public var glyphState: Character {
        let midPopulation = 20
        switch type {
        case .residential:
            if population <= 0 { return "🏚️" }
            if population <= midPopulation { return "🏠" }
            return "🏘️"
        case .commercial:
            if population <= 4 { return "🏪" }
            if population <= midPopulation { return "🏬" }
            return "🏢"
        default:
            return type.glyph
        }
    }
}

public struct Map: Sendable {
    public let width: Int
    public let height: Int
    public var tiles: [Tile]
    
    let trainStationTrafficOffset = 4
    
    public init(width: Int, height: Int, defaultTile: Tile = Tile()) {
        self.width = width
        self.height = height
        self.tiles = Array(repeating: defaultTile, count: width * height)
    }
}
