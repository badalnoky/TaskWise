// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
// Template created by: Bertalan Dálnoky

import Foundation
internal enum Str {
    /// Today
    internal static let dashboardTitle = String(localized: "Dashboard.title", defaultValue: "Today")
    /// Todo
    internal static let dashboardTodoLabel = String(localized: "Dashboard.todoLabel", defaultValue: "Todo")
    /// plus
    internal static let iconsAdd = String(localized: "Icons.add", defaultValue: "plus")
    /// calendar
    internal static let iconsCalendar = String(localized: "Icons.calendar", defaultValue: "calendar")
    /// gear
    internal static let iconsSettings = String(localized: "Icons.settings", defaultValue: "gear")
    /// My Categories
    internal static let settingsCategoriesLabel = String(localized: "Settings.categoriesLabel", defaultValue: "My Categories")
    /// My Columns
    internal static let settingsColumnsLabel = String(localized: "Settings.columnsLabel", defaultValue: "My Columns")
    /// My priorities
    internal static let settingsPrioritiesLabel = String(localized: "Settings.prioritiesLabel", defaultValue: "My priorities")
    /// Settings
    internal static let settingsTitle = String(localized: "Settings.title", defaultValue: "Settings")
}

extension Str {
    private static func stringFrom(format: String, with args: CVarArg...) -> String {
        String(format: format, locale: Locale.current, arguments: args)
    }
}
