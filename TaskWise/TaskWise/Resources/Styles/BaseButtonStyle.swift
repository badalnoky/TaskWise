import SwiftUI

public struct BaseButtonStyle: ButtonStyle {
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
                    .fill(configuration.isPressed ? .button : .accent)
            )
            .padding(.borderWidth)
    }
}
