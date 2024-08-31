import SwiftUI

public struct PadDashboardNavigationBarModifier: ViewModifier {
    var filterText: Binding<String>
    var selectedPriority: Binding<Priority?>
    var selectedCategory: Binding<Category?>
    var didTapTaskAction: (TWTask) -> Void

    @State private var isAddTaskOpen = false
    @State private var isFilterOpen = false
    @State private var isSearchOpen = false

    init(
        filterText: Binding<String>,
        selectedPriority: Binding<Priority?>,
        selectedCategory: Binding<Category?>,
        didTapTaskAction: @escaping (TWTask) -> Void
    ) {
        self.filterText = filterText
        self.selectedPriority = selectedPriority
        self.selectedCategory = selectedCategory
        self.didTapTaskAction = didTapTaskAction

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(Color.appBackground)
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    public func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { filterButton }
                ToolbarItem(placement: .topBarTrailing) { searchButton }
                ToolbarItem(placement: .topBarTrailing) { addButton }
            }
    }
}

extension PadDashboardNavigationBarModifier {
    @ViewBuilder var addButton: some View {
        IconButton(.add) { isAddTaskOpen = true }
            .popover(isPresented: $isAddTaskOpen) {
                AddTaskPopoverView()
            }
    }

    @ViewBuilder var searchButton: some View {
        IconButton(.search) { isSearchOpen = true }
            .popover(isPresented: $isSearchOpen) {
                SearchPopoverView(didTapTaskAction: didTapTaskAction)
            }
    }

    @ViewBuilder var filterButton: some View {
        IconButton(.filter) { isFilterOpen = true }
            .popover(isPresented: $isFilterOpen) {
                FilterPopoverView(
                    filterText: filterText,
                    selectedPriority: selectedPriority,
                    selectedCategory: selectedCategory
                )
            }
    }
}

// swiftlint: disable function_parameter_count
extension View {
    func padDashboardNavigationBar(
        filterText: Binding<String>,
        selectedPriority: Binding<Priority?>,
        selectedCategory: Binding<Category?>,
        didTapTaskAction: @escaping (TWTask) -> Void
    ) -> some View {
        modifier(
            PadDashboardNavigationBarModifier(
                filterText: filterText,
                selectedPriority: selectedPriority,
                selectedCategory: selectedCategory,
                didTapTaskAction: didTapTaskAction
            )
        )
    }
}
