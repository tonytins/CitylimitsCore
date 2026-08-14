import Foundation

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
    
    var startingPopulationRange: ClosedRange<Int> {
        switch self {
        case .residential: 0...4
        case .commercial: 0...2
        case .industrial: 0...3
        case .hotel: 0...2
        default: 0...0
        }
    }

}

public struct Tile: Sendable {
    var type: TileType
    var population: Int
    var powered: Bool
 
    let powerPlanetCapacity = 50
  
    let trainStationPowerDemand = 5
    
    public init(
        type: TileType = .empty,
        population: Int = 0,
        powered: Bool = false
    ) {
        self.type = type
        self.population = population
        self.powered = powered
    }
}

// MARK: - Public APIs

public extension Tile {
        
    var outputCapacity: Int {
        type == .powerPlant ? powerPlanetCapacity : 0
    }
    
    var glyphState: Character {
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


public extension TileType {
    
    var buildCost: Int {
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
    
    var maintenanceCost: Int {
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
    var glyph: Character {
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
    
    var isZone: Bool {
        switch self {
        case .residential, .commercial, .hotel, .industrial: true
        default: false
        }
    }
    
    var activityRequirement: ActivityRequirement? {
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
    
    var taxModel: TaxModel {
        switch self {
        case .residential: return .perResident(numerator: 1, denominator: 1)
        case .commercial: return .perResident(numerator: 2, denominator: 1)
        case .industrial: return .perResident(numerator: 3, denominator: 2)
        case .hotel: return .perResident(numerator: 2, denominator: 1)
        case .trainStation: return .baseWithResidentBonus(
            base: trainStationTaxBase,
            bonusPerResident: trainStationTaxBonus
        )
        case .school: return .baseWithResidentBonus(
            base: schoolTaxBase,
            bonusPerResident: schoolTaxBonus
        )
        case .postOffice: return .baseWithResidentBonus(
            base: postOfficeTaxBase,
            bonusPerResident: postOfficeTaxBonus
        )
        case .hospital, .fireStation: return .baseWithResidentBonus(
            base: emsTaxBase,
            bonusPerResident: emsTaxRonus
        )
        case .empty, .road, .powerPlant, .park, .rail, .fire, .rubble: return .none
        }
    }
    
    var boostsNearbyGrowth: Bool {
        switch self {
        case .trainStation, .school, .postOffice, .hospital, .hotel: true
        default: false
        }
    }
    
    init?(glyph: Character) {
        let normalized = Character(glyph.uppercased())
        guard let match = TileType.allCases.first(where: { $0.glyph == normalized }) else { return nil }
        self = match
    }
}
