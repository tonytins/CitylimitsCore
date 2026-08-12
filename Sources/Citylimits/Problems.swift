import Foundation

public enum CityProblem: String, CaseIterable, Sendable {
    case traffic
    case housing
    case unemployment
    case pollution
}


protocol ProblemReporting {
    func problemSeverities() -> [CityProblem: Int]
}
