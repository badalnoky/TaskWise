import SwiftUI

public enum WidgetButtonType {
    case previous
    case next
    case up
    case down

    var label: Image {
        switch self {
        case .previous: .back
        case .next: .next
        case .up: .up
        case .down: .down
        }
    }

    var intentDirection: Int {
        switch self {
        case .previous: return .previous
        case .next: return .next
        case .up: return .previous
        case .down: return .next
        }
    }
}
