import SwiftUI

extension View {
    func sized(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }

    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }

    func textFieldOverlay() -> some View {
        self
            .padding(.vertical, .padding8)
            .padding(.horizontal, .padding8)
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(Color.accentColor, lineWidth: .borderWidth)
            }
            .padding(.borderWidth)
    }

    func defaultViewPadding() -> some View {
        self
            .padding(.vertical, .padding8)
            .padding(.horizontal, .padding12)
    }

    func defaultListRowSettings() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
    }

    func defaultListSettings() -> some View {
        self
            .listStyle(.plain)
            .frame(height: 200)
            .scrollContentBackground(.hidden)
    }

    func stepRowSettings() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, .padding8)
            .padding(.vertical, .padding4)
    }
}
