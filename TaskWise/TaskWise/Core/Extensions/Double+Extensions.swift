import Foundation
public extension Double {
    /// 0.1
    static let indicatorLowOpacity = 0.1
    /// 0.2
    static let indicatorBaseOpacity = 0.2
    /// 0.4
    static let indicatorScaledWidth = 0.4
    /// 0.5
    static let midOpacity = 0.5
    /// 0.7
    static let defaultAnimationDuration = 0.7
    /// 0.7
    static let pressedOpacity = 0.7
    /// 1
    static let one: Double = 1
    /// 1.6
    static let indicatorHighOpacity = 1.6
    /// 90
    static let indicatorRotation: Double = 90
}

public extension Double {
    static let minute: Double = 60
    static let hour: Double = minute * 60
    static let day: Double = hour * 24
    static let year: Double = day * 365
    static let twoYears: Double = year * 2
}

extension Double {
    static var rightAngle: Double = 90
    static var transitionDuration = 0.5
}

extension Double {
    var normalized: CGFloat {
        self / .maxColorValue
    }
}

public extension Double {
    /// 0.1
    static let watchIndicatorLowOpacity = 0.1
    /// 0.2
    static let watchIndicatorBaseOpacity = 0.2
    /// 1.6
    static let watchIndicatorHighOpacity = 1.6
    /// 90
    static let watchIndicatorRotation: Double = 90
    /// 2.5
    static let watchIndicatorImageRatio = 2.5
}
