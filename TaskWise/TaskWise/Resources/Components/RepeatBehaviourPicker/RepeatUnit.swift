public enum RepeatUnit: String, CaseIterable {
    case day = "Daily"
    case week = "Weekly"
    case month = "Monthly"

    var label: String {
        switch self {
        case .day: "Day"
        case .week: "Week"
        case .month: "Month"
        }
    }

    var encoded: String {
        switch self {
        case .day: "D"
        case .week: "W"
        case .month: "M"
        }
    }

    static func decode(_ character: String) -> RepeatUnit {
        switch character {
        case "D": return .day
        case "W": return .week
        case "M": return .month
        default: return .day
        }
    }
}
