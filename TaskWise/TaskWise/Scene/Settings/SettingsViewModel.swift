import Foundation

@Observable final class SettingsViewModel {
    private var navigator: Navigator<ContentSceneFactory>

    var categories: [String] = ["these", "are", "the", "categories"]
    var columns: [String] = ["these", "are", "the", "columns"]
    var priorities: [Priority] = Priority.defaultPriorities

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
