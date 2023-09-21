import SwiftUI

@Observable final class CalendarViewModel {
    private var navigator: Navigator<ContentSceneFactory>

    var isListed = false
    var selectedDate: Date = .now
    var loadedTasks: [String] = ["these", "are", "the", "loaded", "tasks"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension CalendarViewModel {
    func didTapList() {
        withAnimation {
            isListed.toggle()
        }
    }

    func didTapFilter() {
    }

    func didTapSearch() {
    }

    func didTapAdd() {
    }

    func didTapTask(_ task: String) {
    }
}
