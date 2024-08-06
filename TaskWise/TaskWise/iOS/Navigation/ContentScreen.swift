import Foundation

public enum ContentScreen: Screen {
    case addTask(_ date: Date)
    case calendar
    case dashboard
    case day(_: Date)
    case settings
    case task(_: UUID)
}
