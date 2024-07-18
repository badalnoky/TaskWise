// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
// Template created by: Bertalan Dálnoky
import Foundation

internal enum Str {
    internal enum Alert {
        /// Cancel
        internal static let cancel = String(localized: "Alert.cancel", defaultValue: "Cancel")
        /// Delete task
        internal static let delete = String(localized: "Alert.delete", defaultValue: "Delete task")
        /// Delete all future tasks
        internal static let deleteAll = String(localized: "Alert.deleteAll", defaultValue: "Delete all future tasks")
        /// Delete this task only
        internal static let deleteOnlyThis = String(localized: "Alert.deleteOnlyThis", defaultValue: "Delete this task only")
        /// Are you sure you want to delete this task?
        internal static let message = String(localized: "Alert.message", defaultValue: "Are you sure you want to delete this task?")
        /// OK
        internal static let ok = String(localized: "Alert.ok", defaultValue: "OK")
        /// This is a repeating task.
        internal static let repeatingTask = String(localized: "Alert.repeatingTask", defaultValue: "This is a repeating task.")
        /// Update all future tasks
        internal static let updateAll = String(localized: "Alert.updateAll", defaultValue: "Update all future tasks")
        /// Update this task only
        internal static let updateOnlyThis = String(localized: "Alert.updateOnlyThis", defaultValue: "Update this task only")
        /// This is a repeating task. Would you like to update this task only or all future tasks?
        internal static let updateRepeating = String(localized: "Alert.updateRepeating", defaultValue: "This is a repeating task. Would you like to update this task only or all future tasks?")
    }
    internal enum App {
        /// group.bercidalnoky.TaskWise
        internal static let groupIdentifier = String(localized: "App.groupIdentifier", defaultValue: "group.bercidalnoky.TaskWise")
        /// Dashboard
        internal static let host = String(localized: "App.host", defaultValue: "Dashboard")
        /// TaskWiseApp
        internal static let scheme = String(localized: "App.scheme", defaultValue: "TaskWiseApp")
        /// TaskWise.sqlite
        internal static let sqlite = String(localized: "App.sqlite", defaultValue: "TaskWise.sqlite")
        /// Task
        internal static let taskPath = String(localized: "App.taskPath", defaultValue: "Task")
    }
    internal enum Calendar {
        /// Cancel
        internal static let cancelLabel = String(localized: "Calendar.cancelLabel", defaultValue: "Cancel")
        /// Search
        internal static let searchLabel = String(localized: "Calendar.searchLabel", defaultValue: "Search")
    }
    internal enum ContextMenu {
        /// Delete
        internal static let deleteLabel = String(localized: "ContextMenu.deleteLabel", defaultValue: "Delete")
        /// Done
        internal static let doneLabel = String(localized: "ContextMenu.doneLabel", defaultValue: "Done")
        /// Move to next column
        internal static let nextLabel = String(localized: "ContextMenu.nextLabel", defaultValue: "Move to next column")
        /// Move to previous column
        internal static let previousLabel = String(localized: "ContextMenu.previousLabel", defaultValue: "Move to previous column")
    }
    internal enum Dashboard {
        /// Today
        internal static let title = String(localized: "Dashboard.title", defaultValue: "Today")
    }
    internal enum DataService {
        /// Core Data failed to load!
        internal static let containerFailureMessage = String(localized: "DataService.containerFailureMessage", defaultValue: "Core Data failed to load!")
        /// TaskWise
        internal static let containerName = String(localized: "DataService.containerName", defaultValue: "TaskWise")
        /// TaskWiseMock
        internal static let mockContainer = String(localized: "DataService.mockContainer", defaultValue: "TaskWiseMock")
        /// PreviewTaskWise
        internal static let previewContainerName = String(localized: "DataService.previewContainerName", defaultValue: "PreviewTaskWise")
        /// Could not save the context!
        internal static let saveFailureMessage = String(localized: "DataService.saveFailureMessage", defaultValue: "Could not save the context!")
    }
    internal enum DatePicker {
        /// All-day
        internal static let allDayLabel = String(localized: "DatePicker.allDayLabel", defaultValue: "All-day")
        /// Date
        internal static let dateLabel = String(localized: "DatePicker.dateLabel", defaultValue: "Date")
    }
    internal enum Defaults {
        /// widgetSelectedColum
        internal static let column = String(localized: "Defaults.column", defaultValue: "widgetSelectedColum")
        /// widgetSelectedPage
        internal static let page = String(localized: "Defaults.page", defaultValue: "widgetSelectedPage")
    }
    internal enum Error {
        /// This %@ has Tasks attached to it, therefore it cannot be deleted!
        internal static func existingRelationship(_ p1: String) -> String {
            _sf(
                format: String(localized: "Error.existingRelationship" , defaultValue: "This %@ has Tasks attached to it, therefore it cannot be deleted!"),
                with: p1
            )
        }
        /// An unexpected error occurred!
        internal static let generic = String(localized: "Error.generic", defaultValue: "An unexpected error occurred!")
        /// There must be at least one %@!
        internal static func lastOfKind(_ p1: String) -> String {
            _sf(
                format: String(localized: "Error.lastOfKind" , defaultValue: "There must be at least one %@!"),
                with: p1
            )
        }
        /// Error
        internal static let title = String(localized: "Error.title", defaultValue: "Error")
    }
    internal enum Filter {
        /// Clear all
        internal static let clearAllLabel = String(localized: "Filter.clearAllLabel", defaultValue: "Clear all")
        /// Close
        internal static let closeLabel = String(localized: "Filter.closeLabel", defaultValue: "Close")
        /// No selection
        internal static let noSelectionLabel = String(localized: "Filter.noSelectionLabel", defaultValue: "No selection")
    }
    internal enum Icons {
        /// plus.app.fill
        internal static let add = String(localized: "Icons.add", defaultValue: "plus.app.fill")
        /// chevron.left
        internal static let back = String(localized: "Icons.back", defaultValue: "chevron.left")
        /// calendar
        internal static let calendar = String(localized: "Icons.calendar", defaultValue: "calendar")
        /// checkmark.circle.fill
        internal static let check = String(localized: "Icons.check", defaultValue: "checkmark.circle.fill")
        /// checkmark.circle
        internal static let contextCheck = String(localized: "Icons.contextCheck", defaultValue: "checkmark.circle")
        /// trash
        internal static let delete = String(localized: "Icons.delete", defaultValue: "trash")
        /// chevron.down
        internal static let down = String(localized: "Icons.down", defaultValue: "chevron.down")
        /// pencil
        internal static let edit = String(localized: "Icons.edit", defaultValue: "pencil")
        /// line.3.horizontal.decrease.circle
        internal static let filter = String(localized: "Icons.filter", defaultValue: "line.3.horizontal.decrease.circle")
        /// chevron.right
        internal static let forward = String(localized: "Icons.forward", defaultValue: "chevron.right")
        /// list.bullet.below.rectangle
        internal static let list = String(localized: "Icons.list", defaultValue: "list.bullet.below.rectangle")
        /// ellipsis
        internal static let more = String(localized: "Icons.more", defaultValue: "ellipsis")
        /// magnifyingglass
        internal static let search = String(localized: "Icons.search", defaultValue: "magnifyingglass")
        /// gear
        internal static let settings = String(localized: "Icons.settings", defaultValue: "gear")
        /// chevron.up
        internal static let up = String(localized: "Icons.up", defaultValue: "chevron.up")
    }
    internal enum Indicator {
        /// %d/%d
        internal static func completion(_ p1: Int, _ p2: Int) -> String {
            _sf(
                format: String(localized: "Indicator.completion" , defaultValue: "%d/%d"),
                with: p1, p2
            )
        }
    }
    internal enum RepeatBehaviorPicker {
        /// Back
        internal static let backButtonLabel = String(localized: "RepeatBehaviorPicker.backButtonLabel", defaultValue: "Back")
        /// Repeats every
        internal static let customRepeatLabel = String(localized: "RepeatBehaviorPicker.customRepeatLabel", defaultValue: "Repeats every")
        /// %d
        internal static func dayButtonLabel(_ p1: Int) -> String {
            _sf(
                format: String(localized: "RepeatBehaviorPicker.dayButtonLabel" , defaultValue: "%d"),
                with: p1
            )
        }
        /// %d., 
        internal static func daySeparator(_ p1: Int) -> String {
            _sf(
                format: String(localized: "RepeatBehaviorPicker.daySeparator" , defaultValue: "%d., "),
                with: p1
            )
        }
        /// End repeating on
        internal static let endDateLabel = String(localized: "RepeatBehaviorPicker.endDateLabel", defaultValue: "End repeating on")
        /// Every
        internal static let everyLabel = String(localized: "RepeatBehaviorPicker.everyLabel", defaultValue: "Every")
        /// on the following days: 
        internal static let followingDays = String(localized: "RepeatBehaviorPicker.followingDays", defaultValue: "on the following days: ")
        /// Frequency
        internal static let frequencyLabel = String(localized: "RepeatBehaviorPicker.frequencyLabel", defaultValue: "Frequency")
        /// %d %@s
        internal static func repeatEveryLabel(_ p1: Int, _ p2: String) -> String {
            _sf(
                format: String(localized: "RepeatBehaviorPicker.repeatEveryLabel" , defaultValue: "%d %@s"),
                with: p1, p2
            )
        }
        /// Repeat
        internal static let repeatLabel = String(localized: "RepeatBehaviorPicker.repeatLabel", defaultValue: "Repeat")
        /// %@, 
        internal static func weekdaySeparator(_ p1: String) -> String {
            _sf(
                format: String(localized: "RepeatBehaviorPicker.weekdaySeparator" , defaultValue: "%@, "),
                with: p1
            )
        }
    }
    internal enum Settings {
        /// Add
        internal static let addLabel = String(localized: "Settings.addLabel", defaultValue: "Add")
        /// Cancel
        internal static let cancelLabel = String(localized: "Settings.cancelLabel", defaultValue: "Cancel")
        /// Categories
        internal static let categoriesLabel = String(localized: "Settings.categoriesLabel", defaultValue: "Categories")
        /// Category name
        internal static let categoryPlaceholder = String(localized: "Settings.categoryPlaceholder", defaultValue: "Category name")
        /// Color
        internal static let colorLabel = String(localized: "Settings.colorLabel", defaultValue: "Color")
        /// Column name
        internal static let columnPlaceholder = String(localized: "Settings.columnPlaceholder", defaultValue: "Column name")
        /// Columns
        internal static let columnsLabel = String(localized: "Settings.columnsLabel", defaultValue: "Columns")
        /// High
        internal static let examplePriority = String(localized: "Settings.examplePriority", defaultValue: "High")
        /// Example
        internal static let exampleTitle = String(localized: "Settings.exampleTitle", defaultValue: "Example")
        /// Priorities
        internal static let prioritiesLabel = String(localized: "Settings.prioritiesLabel", defaultValue: "Priorities")
        /// Priority name
        internal static let priorityPlaceholder = String(localized: "Settings.priorityPlaceholder", defaultValue: "Priority name")
        /// Settings
        internal static let title = String(localized: "Settings.title", defaultValue: "Settings")
    }
    internal enum Task {
        /// Category
        internal static let categoryLabel = String(localized: "Task.categoryLabel", defaultValue: "Category")
        /// Color
        internal static let colorLabel = String(localized: "Task.colorLabel", defaultValue: "Color")
        /// Create task
        internal static let createButtonLabel = String(localized: "Task.createButtonLabel", defaultValue: "Create task")
        /// Current column
        internal static let currentColumnLabel = String(localized: "Task.currentColumnLabel", defaultValue: "Current column")
        /// Delete
        internal static let deleteButton = String(localized: "Task.deleteButton", defaultValue: "Delete")
        /// Description
        internal static let descriptionLabel = String(localized: "Task.descriptionLabel", defaultValue: "Description")
        /// Ends
        internal static let endsLabel = String(localized: "Task.endsLabel", defaultValue: "Ends")
        /// Priority
        internal static let priorityLabel = String(localized: "Task.priorityLabel", defaultValue: "Priority")
        /// Save
        internal static let saveButton = String(localized: "Task.saveButton", defaultValue: "Save")
        /// Starting column
        internal static let startingColumnLabel = String(localized: "Task.startingColumnLabel", defaultValue: "Starting column")
        /// Starts
        internal static let startsLabel = String(localized: "Task.startsLabel", defaultValue: "Starts")
        /// Step
        internal static let stepLabel = String(localized: "Task.stepLabel", defaultValue: "Step")
        /// Steps
        internal static let stepsLabel = String(localized: "Task.stepsLabel", defaultValue: "Steps")
        /// Title
        internal static let titleLabel = String(localized: "Task.titleLabel", defaultValue: "Title")
    }
    internal enum TaskItem {
        /// %@ priority
        internal static func priority(_ p1: String) -> String {
            _sf(
                format: String(localized: "TaskItem.priority" , defaultValue: "%@ priority"),
                with: p1
            )
        }
    }
    internal enum Watch {
        internal enum Widget {
            /// %d done
            internal static func done(_ p1: Int) -> String {
                _sf(
                    format: String(localized: "Watch.Widget.done" , defaultValue: "%d done"),
                    with: p1
                )
            }
            /// %d/%d tasks today
            internal static func inline(_ p1: Int, _ p2: Int) -> String {
                _sf(
                    format: String(localized: "Watch.Widget.inline" , defaultValue: "%d/%d tasks today"),
                    with: p1, p2
                )
            }
            /// %d tasks today
            internal static func today(_ p1: Int) -> String {
                _sf(
                    format: String(localized: "Watch.Widget.today" , defaultValue: "%d tasks today"),
                    with: p1
                )
            }
        }
    }
}

extension Str {
    private static func _sf(format: String, with args: CVarArg...) -> String {
        String(format: format, locale: Locale.current, arguments: args)
    }
}
