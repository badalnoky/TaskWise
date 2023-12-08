import Foundation
import WidgetKit

public enum WidgetTimelineService {
    static func refreshWidgetOf(kind: TaskWiseWidgetKind) {
        WidgetCenter.shared.reloadTimelines(ofKind: String.completionWidgetKind)
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
