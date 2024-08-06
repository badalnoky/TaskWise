import SwiftUI

public struct WidgetPageButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.widgetBackground)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.padding8)
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(.accent)
                    .frame(height: 25)
            )
    }
}
