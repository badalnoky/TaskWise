import SwiftUI

public struct IconButton: View {
    private var icon: Image
    private var action: () -> Void

    public var body: some View {
        Button(
            action: {
                withAnimation { action() }
            },
            label: {
                icon.fittedToSize(.defaultIconSize)
            }
        )
    }

    public init(_ icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
}

#Preview {
    IconButton(Image(systemName: Str.iconsSettings)) {}
}
