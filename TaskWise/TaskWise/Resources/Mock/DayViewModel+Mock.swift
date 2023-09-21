#if DEBUG
extension DayViewModel {
    static var mock: DayViewModel {
        DayViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }
}
#endif
