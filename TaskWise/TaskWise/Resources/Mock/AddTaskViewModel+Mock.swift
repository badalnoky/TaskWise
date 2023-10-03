#if DEBUG
extension AddTaskViewModel {
    static var mock: AddTaskViewModel {
        AddTaskViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }
}
#endif
