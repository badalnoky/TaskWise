import Foundation

#if DEBUG
extension TaskColumn {
    static var mock: TaskColumn {
        let column = TaskColumn(context: PreviewDataController.global.context)
        column.wId = UUID()
        column.wIndex = 1
        column.wName = "Column"
        return column
    }
}
#endif
