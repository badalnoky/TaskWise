import SwiftUI

public struct SettingsNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let isEditing: Bool
    let editAction: () -> Void
    let addAction: () -> Void

    init(isEditing: Bool, editAction: @escaping () -> Void, addAction: @escaping () -> Void) {
        self.isEditing = isEditing
        self.editAction = editAction
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
                ToolbarItem(placement: .principal) { Text(Str.settingsTitle).textStyle(.largeTitle) }
                if isEditing {
                    ToolbarItem(placement: .topBarTrailing) { addButton }
                }
                ToolbarItem(placement: .topBarTrailing) { editButton }
            }
    }
}

extension SettingsNavigationBarModifier {
    @ViewBuilder var backButton: some View {
        IconButton(.back) { presentationMode.wrappedValue.dismiss() }
    }

    @ViewBuilder var editButton: some View {
        IconButton(.edit, action: editAction)
    }

    @ViewBuilder var addButton: some View {
        IconButton(.add, action: addAction)
    }
}
