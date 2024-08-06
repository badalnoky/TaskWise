import Foundation

#if DEBUG
extension Priority {
    static var mock: Priority {
        let priority = Priority(context: PreviewDataService.global.context)
        priority.wId = UUID()
        priority.wLevel = 1
        priority.wName = "Priority"
        return priority
    }
}
#endif
