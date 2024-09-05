import Combine
import Resolver
import SwiftUI

@Observable final class FilterPopoverViewModel {
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    var priorities: [Priority] = []
    var categories: [Category] = []

    init(dataService: DataServiceInput = Resolver.resolve()) {
        self.dataService = dataService

        registerBindings()
    }
}

private extension FilterPopoverViewModel {
    private func registerBindings() {
        registerPriorityBinding()
        registerCategoryBinding()
    }

    private func registerPriorityBinding() {
        dataService.fetchPriorities()
        dataService.priorities
            .sink { [weak self] in
                self?.priorities = $0
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataService.fetchCategories()
        dataService.categories
            .sink { [weak self] in
                self?.categories = $0
            }
            .store(in: &cancellables)
    }
}
