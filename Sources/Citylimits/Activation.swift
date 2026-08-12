import Foundation

public protocol ActivityReporting {
    func isActive(at point: Point) -> Bool
}

public enum ActivityRequirement {
    case powerOnly
    case powerAndAdjacent(to: TileType)
    case powerAndAdjacentPopulated(TileType)
}
