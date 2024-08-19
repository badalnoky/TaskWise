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
                    .background {
                        RoundedRectangle(cornerRadius: 12).fill(Color.appBackground).sized(.iconButtonSize)
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                    .shadow(color: Color.white.opacity(0.7), radius: 2, x: -1, y: -1)
            }
        )
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
