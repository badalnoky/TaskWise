#if DEBUG
extension TaskViewModel {
    static var mock: TaskViewModel {
        TaskViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }
}
#endif
