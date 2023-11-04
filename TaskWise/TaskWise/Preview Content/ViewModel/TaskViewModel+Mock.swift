import Foundation

#if DEBUG
extension TaskViewModel {
    static var mock: TaskViewModel {
        TaskViewModel(navigator: .init(sceneFactory: .init(), root: .calendar), taskId: UUID())
    }
}
#endif
