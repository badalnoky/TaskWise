#if DEBUG
extension CalendarViewModel {
    static var mock: CalendarViewModel {
        CalendarViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }
}
#endif
