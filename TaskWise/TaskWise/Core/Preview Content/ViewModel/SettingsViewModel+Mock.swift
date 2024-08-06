#if DEBUG
extension SettingsViewModel {
    static var mock: SettingsViewModel {
        SettingsViewModel(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }
}
#endif
