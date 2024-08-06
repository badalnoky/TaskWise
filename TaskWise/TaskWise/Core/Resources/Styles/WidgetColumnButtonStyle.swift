import SwiftUI

public struct WidgetColumnButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.widgetBackground)
            .padding(.padding8)
            .background(
                RoundedRectangle(cornerRadius: .padding12)
                    .fill(.accent)
                    .frame(width: 35, height: 30)
            )
    }
}
