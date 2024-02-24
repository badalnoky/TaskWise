import Foundation
import WidgetKit

public enum WidgetTimelineService {
    private typealias Txt = Str.Defaults
    static func refreshWidgetOf(kind: TaskWiseWidgetKind) {
        WidgetCenter.shared.reloadTimelines(ofKind: kind.kind)
    }

    static func initiateWidgetDefaults() {
        UserDefaults.standard.set(Int.zero, forKey: Txt.page)
        UserDefaults.standard.set(Int.zero, forKey: Txt.column)
    }

    static func changePageIn(direction: Int) {
        var page = UserDefaults.standard.integer(forKey: Txt.page)
        if direction == .zero {
            page = page.previous
        } else {
            page = page.next
        }
        UserDefaults.standard.set(page, forKey: Txt.page)
    }

    static func changeColumnIn(direction: Int) {
        var column = UserDefaults.standard.integer(forKey: Txt.column)
        if direction == .zero {
            column = column.previous
        } else {
            column = column.next
        }
        UserDefaults.standard.set(Int.zero, forKey: Txt.page)
        UserDefaults.standard.set(column, forKey: Txt.column)
    }

    static func getWidgetState() -> (Int, Int) {
        let column = UserDefaults.standard.integer(forKey: Txt.column)
        let page = UserDefaults.standard.integer(forKey: Txt.page)
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
