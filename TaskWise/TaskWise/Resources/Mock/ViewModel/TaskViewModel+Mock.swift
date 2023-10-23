import Foundation

#if DEBUG
extension TaskViewModel {
    static var mock: TaskViewModel {
        TaskViewModel()
    }
}
#endif
