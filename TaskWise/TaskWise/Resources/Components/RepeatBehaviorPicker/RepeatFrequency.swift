import Foundation

public enum RepeatFrequency: String, CaseIterable {
    case never = "Never"
    case daily = "Every Day"
    case weekly = "Every Week"
    case monthly = "Every Month"
    case yearly = "Every Year"
    case custom = "Custom"
}
