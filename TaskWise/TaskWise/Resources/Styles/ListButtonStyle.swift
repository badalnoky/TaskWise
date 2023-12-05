import SwiftUI

public struct ListButtonStyle: ButtonStyle {
    var color: Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(.body)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, .padding8)
            .padding(.leading, .listButtonPadding)
            .background {
                HStack {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .fill(color)
                        .frame(width: .listCategoryWidth)
                    Spacer()
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: .cornerRadius))
    }
}
