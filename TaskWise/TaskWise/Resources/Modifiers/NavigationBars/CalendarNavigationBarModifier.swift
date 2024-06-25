import SwiftUI

public struct CalendarNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let isListed: Bool
    let listAction: () -> Void
    let searchAction: () -> Void
    let filterAction: () -> Void

    init(
        isListed: Bool,
        listAction: @escaping () -> Void,
        searchAction: @escaping () -> Void,
        filterAction: @escaping () -> Void
    ) {
        self.isListed = isListed
        self.listAction = listAction
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
                ToolbarItem(placement: .topBarLeading) { backButton }
                if isListed {
                    ToolbarItem(placement: .topBarTrailing) { filterButton }
                }
                ToolbarItem(placement: .topBarTrailing) { listButton }
                ToolbarItem(placement: .topBarTrailing) { searchButton }
            }
    }
}

extension CalendarNavigationBarModifier {
    @ViewBuilder var backButton: some View {
        IconButton(.back) { presentationMode.wrappedValue.dismiss() }
    }

    @ViewBuilder var listButton: some View {
        IconButton(.list, action: listAction)
    }

    @ViewBuilder var searchButton: some View {
        IconButton(.search, action: searchAction)
    }

    @ViewBuilder var filterButton: some View {
        IconButton(.filter, action: filterAction)
    }
}

extension View {
    // swiftlint: disable function_parameter_count
    func calendarNavigationBar(
        isListed: Bool,
        listAction: @escaping () -> Void,
        searchAction: @escaping () -> Void,
        filterAction: @escaping () -> Void
    ) -> some View {
        modifier(
            CalendarNavigationBarModifier(
                isListed: isListed,
                listAction: listAction,
                searchAction: searchAction,
                filterAction: filterAction
            )
        )
    }
}
