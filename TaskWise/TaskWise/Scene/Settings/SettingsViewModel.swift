import Foundation

@Observable final class SettingsViewModel {
    private var navigator: Navigator<ContentSceneFactory>

    var categories: [String] = ["these", "are", "the", "categories"]
    var columns: [String] = ["these", "are", "the", "columns"]
    var priorities: [String] = ["these", "are", "the", "priority", "levels"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension SettingsViewModel {
    func didTapAddCategory() {
    }

    func didTapAddColumns() {
    }

    func didTapAddPriority() {
    }
}
