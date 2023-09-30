// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
// Template created by: Bertalan Dálnoky

import Foundation
internal enum Str {
    /// Todo
    internal static let calendarTodoLabel = String(localized: "Calendar.todoLabel", defaultValue: "Todo")
    /// Today
    internal static let dashboardTitle = String(localized: "Dashboard.title", defaultValue: "Today")
    /// Todo
    internal static let dashboardTodoLabel = String(localized: "Dashboard.todoLabel", defaultValue: "Todo")
    /// Todo
    internal static let dayTodoLabel = String(localized: "Day.todoLabel", defaultValue: "Todo")
    /// plus
    internal static let iconsAdd = String(localized: "Icons.add", defaultValue: "plus")
    /// calendar
    internal static let iconsCalendar = String(localized: "Icons.calendar", defaultValue: "calendar")
    /// checkmark.circle.fill
    internal static let iconsCheck = String(localized: "Icons.check", defaultValue: "checkmark.circle.fill")
    /// pencil
    internal static let iconsEdit = String(localized: "Icons.edit", defaultValue: "pencil")
    /// line.3.horizontal.decrease.circle
    internal static let iconsFilter = String(localized: "Icons.filter", defaultValue: "line.3.horizontal.decrease.circle")
    /// list.bullet.below.rectangle
    internal static let iconsList = String(localized: "Icons.list", defaultValue: "list.bullet.below.rectangle")
    /// magnifyingglass
    internal static let iconsSearch = String(localized: "Icons.search", defaultValue: "magnifyingglass")
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
    /// Category
    internal static let taskCategoryLabel = String(localized: "Task.categoryLabel", defaultValue: "Category")
    /// Color
    internal static let taskColorLabel = String(localized: "Task.colorLabel", defaultValue: "Color")
    /// Delete
    internal static let taskDeleteButton = String(localized: "Task.deleteButton", defaultValue: "Delete")
    /// Ends
    internal static let taskEndsLabel = String(localized: "Task.endsLabel", defaultValue: "Ends")
    /// Priority
    internal static let taskPriorityLabel = String(localized: "Task.priorityLabel", defaultValue: "Priority")
    /// Repeats
    internal static let taskRepeatLabel = String(localized: "Task.repeatLabel", defaultValue: "Repeats")
    /// Save
    internal static let taskSaveButton = String(localized: "Task.saveButton", defaultValue: "Save")
    /// Starts
    internal static let taskStartsLabel = String(localized: "Task.startsLabel", defaultValue: "Starts")
    /// Steps
    internal static let taskStepsLabel = String(localized: "Task.stepsLabel", defaultValue: "Steps")
}

extension Str {
    private static func stringFrom(format: String, with args: CVarArg...) -> String {
        String(format: format, locale: Locale.current, arguments: args)
    }
}
