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
    case fireStation
    case fire
    case rubble
    
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
        case .empty, .fire, .rubble: 0
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
        }
    }
    
    var startingPopulationRange: ClosedRange<Int> {
        switch self {
        case .residential: 0...4
        case .commercial: 0...2
        case .industrial: 0...3
        default: 0...0
        }
    }
    
    public var isZone: Bool {
        switch self {
        case .residential, .commercial, .industrial: true
        default: false
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
        let highPopulation = 20
        switch type {
        case .residential:
            if population <= 0 { return "🏚️" }
            if population <= highPopulation { return "🏘️" }
            return "🏠"
        case .commercial:
            if population <= 4 { return "🏪" }
            if population <= highPopulation { return "🏢" }
            return "🏬"
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
