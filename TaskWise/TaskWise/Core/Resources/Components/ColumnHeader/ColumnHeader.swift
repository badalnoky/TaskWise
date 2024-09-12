import SwiftUI

public struct ColumnHeader {
    var text: String
    var style: ColumnHeaderStyle

    init(text: String, style: ColumnHeaderStyle = .iOS) {
        self.text = text
        self.style = style
    }
}

extension ColumnHeader: View {
    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundStyle(.appBackground)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, .padding8)
            .padding(.bottom, .padding8)
            .background {
                VStack(spacing: .zero) {
                    Rectangle()
                        .fill(.accent)
                        .clipShape(.rect(topLeadingRadius: .padding16, topTrailingRadius: .padding16))
                }
            }
            .padding(.horizontal, .padding8)
    }
}

#Preview {
    ColumnHeader(text: "TODO")
}
