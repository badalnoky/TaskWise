import SwiftUI

public struct TextButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isEnabled ? .accent.opacity(configuration.isPressed ? .pressedOpacity : .one) : .gray)
            .textStyle(.body)
            .padding(.horizontal, .padding8)
            .padding(.vertical, .padding8)
    }
}
