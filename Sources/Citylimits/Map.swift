import Foundation

public struct Point: Equatable, Hashable, Sendable {
    var x: Int
    var y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

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
    
    func index(for point: Point) -> Int
    {
        point.y * width + point.x
    }
    
    subscript(point: Point) -> Tile {
        get {
            return tiles[index(for: point)]
        }
        set {
            return tiles[index(for: point)] = newValue
        }
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

    func valid(point: Point) -> Bool {
        point.x >= 0 && point.x < width && point.y >= 0 && point.y < height
    }
}

// MARK: - Public API

extension Map {
    var maintenanceCost: Int {
        tiles.reduce(0) { $0 + $1.type.maintenanceCost }
    }
    
    func neighbors(of point: Point, includeDiagonals: Bool = false) -> [Point] {
        var deltas = [(0, -1), (0, 1), (-1, 0), (1, 0)]
        
        if includeDiagonals {
            deltas += [(-1, -1), (-1, 1), (1, -1), (1, 1)]
        }
        
        return deltas.compactMap { dx, dy in
            let p = Point(x: point.x + dx, y: point.y + dy)
            return valid(point: p) ? p : nil
        }
    }
    
    mutating func recomputePower() {
        var remainingCapacity = tiles.reduce(0) { $0 + $1.outputCapacity }
    }
    
    mutating func clear() {
        tiles = Array(repeating: Tile(), count: tiles.count)
    }
}
