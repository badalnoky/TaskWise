import SwiftUI

public struct DashboardNavigationBarModifier: ViewModifier {
    let settingsAction: () -> Void
    let calendarAction: () -> Void
    let addAction: () -> Void

    init(
        settingsAction: @escaping () -> Void,
        calendarAction: @escaping () -> Void,
        addAction: @escaping () -> Void
    ) {
        self.settingsAction = settingsAction
        self.calendarAction = calendarAction
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
                ToolbarItem(placement: .topBarLeading) { settingsButton }
                ToolbarItem(placement: .topBarTrailing) { calendarButton }
                ToolbarItem(placement: .topBarTrailing) { addButton }
            }
    }
}

extension DashboardNavigationBarModifier {
    @ViewBuilder var settingsButton: some View {
        IconButton(.settings, action: settingsAction)
    }

    @ViewBuilder var calendarButton: some View {
        IconButton(.calendar, action: calendarAction)
    }

    @ViewBuilder var addButton: some View {
        IconButton(.add, action: addAction)
    }
}

extension View {
    func dashboardNavigationBar(
        settingsAction: @escaping () -> Void,
        calendarAction: @escaping () -> Void,
        addAction: @escaping () -> Void
    ) -> some View {
        modifier(
            DashboardNavigationBarModifier(
                settingsAction: settingsAction,
                calendarAction: calendarAction,
                addAction: addAction
            )
        )
    }
}
