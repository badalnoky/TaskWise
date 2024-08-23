import SwiftUI

public struct PadDashboardNavigationBarModifier: ViewModifier {
    let searchAction: () -> Void
    let filterAction: () -> Void

    init(
        searchAction: @escaping () -> Void,
        filterAction: @escaping () -> Void
    ) {
        self.searchAction = searchAction
        self.filterAction = filterAction

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
            }
    }
}

extension PadDashboardNavigationBarModifier {
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
        filterAction: @escaping () -> Void
    ) -> some View {
        modifier(
            PadDashboardNavigationBarModifier(
                searchAction: searchAction,
                filterAction: filterAction
            )
        )
    }
}
