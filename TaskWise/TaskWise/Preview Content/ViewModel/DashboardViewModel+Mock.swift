#if DEBUG
extension DashboardViewModel {
    static var mock: DashboardViewModel {
        DashboardViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }
}
#endif
