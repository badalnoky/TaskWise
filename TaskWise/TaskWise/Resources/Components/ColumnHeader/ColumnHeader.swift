import SwiftUI

public struct ColumnHeader {
    var text: String
}

extension ColumnHeader: View {
    public var body: some View {
        Text(text)
            .font(TextStyle.title.font)
            .foregroundStyle(.appBackground)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, .padding12)
            .padding(.bottom, .padding12)
            .background {
                VStack(spacing: .zero) {
                    Rectangle()
                        .fill(.accent)
                        .clipShape(
                            .rect(topLeadingRadius: .padding16, topTrailingRadius: .padding16)
                        )
                }
            }
            .padding(.horizontal, .padding16)
    }
}

#Preview {
    ColumnHeader(text: "TODO")
}
