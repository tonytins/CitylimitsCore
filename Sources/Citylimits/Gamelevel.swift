import Foundation

public enum GameLevel: Int, CaseIterable, Sendable {
    case easy = 0
    case medium = 1
    case hard = 2
    
    public var startingFunds: Int {
        switch self {
        case .easy: return 20_000
        case .medium: return 10_000
        case .hard: return 5_000
        }
    }
}
