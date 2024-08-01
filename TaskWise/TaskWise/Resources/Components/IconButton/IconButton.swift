import SwiftUI

public struct IconButton: View {
    @Environment(\.isEnabled) private var isEnabled

    private var icon: Image
    private var isAnimated: Bool
    private var action: () -> Void

    public var body: some View {
        Button(
            action: {
                if isAnimated {
                    withAnimation(.smooth) { action() }
                } else {
                    action()
                }
            },
            label: {
                icon.fittedToSize(.defaultIconSize)
                    .foregroundStyle(.accent.opacity(isEnabled ? .one : .midOpacity))
            }
        )
        .sized(.iconButtonSize)
    }

    public init(_ icon: Image, isAnimated: Bool = true, action: @escaping () -> Void) {
        self.icon = icon
        self.isAnimated = isAnimated
        self.action = action
    }
}

#Preview {
    IconButton(Image.settings) {}
}
