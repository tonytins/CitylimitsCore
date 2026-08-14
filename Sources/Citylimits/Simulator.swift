import Foundation

public typealias DeltaTime = TimeInterval

public enum Speed: Sendable, CaseIterable {
    case paused
    case slow
    case normal
    case fast
    case superFast
    
    public var simStepsPerUpdate: Int {
        switch self {
        case .paused: 0
        case .slow, .normal, .fast: 1
        case .superFast: 5
        }
    }
}

public final class Simulator<Subject: Updatable> {
    public var subject: Subject
    public var time: DeltaTime
    
    public init(subject: Subject, startTime: DeltaTime = 0.0) {
        self.subject = subject
        self.time = startTime
    }
    
    public func step(dt: DeltaTime = 1.0) {
        subject.update(dt: dt)
        time +=  dt
    }
    
    public func step(speed: Speed) {
        step(dt: Double(speed.simStepsPerUpdate))
    }
}
