import Foundation
import WidgetKit

public enum WidgetTimelineService {
    static func refreshWidgetOf(kind: TaskWiseWidgetKind) {
        WidgetCenter.shared.reloadTimelines(ofKind: kind.kind)
    }

    static func initiateWidgetDefaults() {
        UserDefaults.standard.set(Int.zero, forKey: Str.defaultsPage)
        UserDefaults.standard.set(Int.zero, forKey: Str.defaultsColumn)
    }

    static func changePageIn(direction: Int) {
        var page = UserDefaults.standard.integer(forKey: Str.defaultsPage)
        if direction == .zero {
            page = page.previous
        } else {
            page = page.next
        }
        UserDefaults.standard.set(page, forKey: Str.defaultsPage)
    }

    static func changeColumnIn(direction: Int) {
        var column = UserDefaults.standard.integer(forKey: Str.defaultsColumn)
        if direction == .zero {
            column = column.previous
        } else {
            column = column.next
        }
        UserDefaults.standard.set(Int.zero, forKey: Str.defaultsPage)
        UserDefaults.standard.set(column, forKey: Str.defaultsColumn)
    }

    static func getWidgetState() -> (Int, Int) {
        let column = UserDefaults.standard.integer(forKey: Str.defaultsColumn)
        let page = UserDefaults.standard.integer(forKey: Str.defaultsPage)
        return (column, page)
    }
}

public enum TaskWiseWidgetKind {
    case completion
    case task

    var kind: String {
        switch self {
        case .completion: String.completionWidgetKind
        case .task: String.taskWidgetKind
        }
    }
}
