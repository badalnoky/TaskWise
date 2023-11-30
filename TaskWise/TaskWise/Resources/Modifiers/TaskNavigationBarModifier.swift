import SwiftUI

public struct TaskNavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let editAction: () -> Void

    init(editAction: @escaping () -> Void) {
        self.editAction = editAction

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
                ToolbarItem(placement: .topBarTrailing) { editButton }
            }
    }
}

extension TaskNavigationBarModifier {
    @ViewBuilder var backButton: some View {
        IconButton(.back) { presentationMode.wrappedValue.dismiss() }
    }

    @ViewBuilder var editButton: some View {
        IconButton(.edit, action: editAction)
    }
}
