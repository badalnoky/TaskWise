import SwiftUI

public struct PadDashboardNavigationBarModifier: ViewModifier {
    let searchAction: () -> Void
    let filterAction: () -> Void
    let addAction: () -> Void

    init(
        searchAction: @escaping () -> Void,
        filterAction: @escaping () -> Void,
        addAction: @escaping () -> Void
    ) {
        self.searchAction = searchAction
        self.filterAction = filterAction
        self.addAction = addAction

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
        IconButton(.add, action: addAction)
    }

    @ViewBuilder var searchButton: some View {
        IconButton(.search, action: searchAction)
    }

    @ViewBuilder var filterButton: some View {
        IconButton(.filter, action: filterAction)
    }
}

extension View {
    func padDashboardNavigationBar(
        searchAction: @escaping () -> Void,
        filterAction: @escaping () -> Void,
        addAction: @escaping () -> Void
    ) -> some View {
        modifier(
            PadDashboardNavigationBarModifier(
                searchAction: searchAction,
                filterAction: filterAction,
                addAction: addAction
            )
        )
    }
}
