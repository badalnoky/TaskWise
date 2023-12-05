import SwiftUI

extension View {
    func sized(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }

    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }

    func textFieldOverlay(_ isEnabled: Bool = true) -> some View {
        self
            .padding(.vertical, .padding8)
            .padding(.horizontal, .padding8)
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(Color.accentColor.opacity(isEnabled ? 1 : 0.5), lineWidth: .borderWidth)
            }
            .padding(.borderWidth)
    }

    func defaultViewPadding() -> some View {
        self
            .padding(.vertical, .padding8)
            .padding(.horizontal, .padding16)
    }

    func defaultListRowSettings() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
    }

    func defaultListSettings() -> some View {
        self
            .listStyle(.plain)
            .frame(height: 200)
            .scrollContentBackground(.hidden)
    }

    func stepRowSettings() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, .padding8)
            .padding(.vertical, .padding4)
    }

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

    func dayNavigationBar(
        filterAction: @escaping () -> Void,
        addAction: @escaping () -> Void
    ) -> some View {
        modifier(
            DayNavigationBarModifier(
                filterAction: filterAction,
                addAction: addAction
            )
        )
    }

    // swiftlint: disable: function_parameter_count
    func settingsNavigationBar(
        isEditing: Bool,
        editAction: @escaping () -> Void,
        addAction: @escaping () -> Void,
        finishAction: @escaping () -> Void
    ) -> some View {
        modifier(
            SettingsNavigationBarModifier(isEditing: isEditing, editAction: editAction, addAction: addAction, finishAction: finishAction)
        )
    }

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
    // swiftlint: enable: function_parameter_count

    func taskNavigationBar(editAction: @escaping () -> Void) -> some View {
        modifier(TaskNavigationBarModifier(editAction: editAction))
    }

    func contrastTo(color: Color) -> some View {
        var red: CGFloat = .zero
        var green: CGFloat = .zero
        var blue: CGFloat = .zero
        var alpha: CGFloat = .zero
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return  luminance < 0.6 ? self.foregroundColor(.lightContrast) : self.foregroundColor(.darkContrast)
    }
}
