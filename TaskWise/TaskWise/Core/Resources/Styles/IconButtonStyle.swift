import SwiftUI

public struct IconButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.accent.opacity(isEnabled ? .one : .midOpacity))
            .padding(.padding8)
            .background {
                RoundedRectangle(cornerRadius: .padding12).fill(Color.appBackground).sized(.iconButtonSize)
            }
            .shadow(color: configuration.isPressed ? .clear : Color.lowerShadow, radius: 2, x: 2, y: 2)
            .shadow(color: configuration.isPressed ? .clear : Color.upperShadow, radius: 2, x: -1, y: -1)
    }
}
