import Foundation

public enum ContentScreen: Screen {
    case addTask
    case calendar
    case dashboard
    case day(_: Date)
    case settings
    case task(_: UUID)
}
