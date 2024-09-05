import SwiftUI

public struct SettingsNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let editAction: () -> Void
    let addAction: () -> Void
    let finishAction: () -> Void

    init(
        editAction: @escaping () -> Void,
        addAction: @escaping () -> Void,
        finishAction: @escaping () -> Void
    ) {
        self.editAction = editAction
        self.addAction = addAction
        self.finishAction = finishAction

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
                ToolbarItem(placement: .principal) { Text(Str.Settings.title).textStyle(.largeTitle) }
                ToolbarItem(placement: .topBarTrailing) { addButton }
                ToolbarItem(placement: .topBarTrailing) { editButton }
            }
    }
}

extension SettingsNavigationBarModifier {
    @ViewBuilder var backButton: some View {
        IconButton(.back) {
            finishAction()
            presentationMode.wrappedValue.dismiss()
        }
    }

    @ViewBuilder var editButton: some View {
        IconButton(.edit, action: editAction)
    }

    @ViewBuilder var addButton: some View {
        IconButton(.add, action: addAction)
    }
}

extension View {
    func settingsNavigationBar(
        editAction: @escaping () -> Void,
        addAction: @escaping () -> Void,
        finishAction: @escaping () -> Void
    ) -> some View {
        modifier(
            SettingsNavigationBarModifier(editAction: editAction, addAction: addAction, finishAction: finishAction)
        )
    }
}
