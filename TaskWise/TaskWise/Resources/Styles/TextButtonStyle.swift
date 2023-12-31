import SwiftUI

public struct TextButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accent.opacity(configuration.isPressed ? .pressedOpacity : .one))
            .textStyle(.body)
            .padding(.horizontal, .padding8)
            .padding(.vertical, .padding8)
    }
}
