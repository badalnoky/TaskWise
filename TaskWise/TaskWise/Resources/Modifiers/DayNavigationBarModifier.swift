import SwiftUI

public struct DayNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let filterAction: () -> Void
    let addAction: () -> Void

    init(filterAction: @escaping () -> Void, addAction: @escaping () -> Void) {
        self.filterAction = filterAction
        self.addAction = addAction

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(.appBackground)
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
                ToolbarItem(placement: .topBarTrailing) { filterButton }
                ToolbarItem(placement: .topBarTrailing) { addButton }
            }
    }
}

extension DayNavigationBarModifier {
    @ViewBuilder var backButton: some View {
        IconButton(.back) { presentationMode.wrappedValue.dismiss() }
    }

    @ViewBuilder var filterButton: some View {
        IconButton(.filter, action: filterAction)
    }

    @ViewBuilder var addButton: some View {
        IconButton(.add, action: addAction)
    }
}
