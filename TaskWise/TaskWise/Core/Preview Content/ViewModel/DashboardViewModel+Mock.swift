#if DEBUG
extension PhoneDashboardViewModel {
    static var mock: PhoneDashboardViewModel {
        PhoneDashboardViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }
}
#endif
