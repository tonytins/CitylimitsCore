import Foundation

public struct Map: Sendable, ProblemReporting {
 
    public let width: Int
    public let height: Int
    public var tiles: [Tile]
    
    let trainStationTrafficOffset = 4
    
    public init(width: Int, height: Int, defaultTile: Tile = Tile()) {
        self.width = width
        self.height = height
        self.tiles = Array(repeating: defaultTile, count: width * height)
    }
    
    func problemSeverities() -> [CityProblem : Int] {
        [
            // TODO: add functions for all these
            .traffic: 0,
            .housing: 0,
            .unemployment: 0,
            .pollution: 0
        ]
    }
}

