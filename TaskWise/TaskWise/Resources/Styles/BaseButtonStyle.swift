import SwiftUI

public struct BaseButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .accent : .button)
            .textStyle(.body)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.padding16)
            .overlay {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(configuration.isPressed ? .accent : .clear, lineWidth: .borderWidth)
            }
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(isEnabled ? (configuration.isPressed ? .button : .accent) : .accent.opacity(.midOpacity))
            )
            .padding(.borderWidth)
    }
}
