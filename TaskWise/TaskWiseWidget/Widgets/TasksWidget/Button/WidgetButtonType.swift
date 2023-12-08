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
}
