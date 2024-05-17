import Foundation

public enum RepeatFrequency: String, CaseIterable {
    case never = "Never"
    case daily = "Every Day"
    case weekly = "Every Week"
    case monthly = "Every Month"
    case yearly = "Every Year"
    case custom = "Custom"

    var encoded: String {
        switch self {
        case .never: "N"
        case .daily: "D"
        case .weekly: "W"
        case .monthly: "M"
        case .yearly: "Y"
        case .custom: "C"
        }
    }

    static func decode(_ character: String) -> RepeatFrequency {
        switch character {
        case "D": return .daily
        case "W": return .weekly
        case "M": return .monthly
        case "Y": return .yearly
        case "C": return .custom
        default: return .never
        }
    }
}
