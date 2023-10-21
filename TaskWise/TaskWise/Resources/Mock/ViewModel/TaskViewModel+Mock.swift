import Foundation

#if DEBUG
extension TaskViewModel {
    static var mock: TaskViewModel {
        TaskViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard), taskId: Task.mock.id)
    }
}
#endif
