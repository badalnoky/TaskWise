import SwiftUI

extension View {
    func sized(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size, alignment: .center)
    }

    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }

    func textFieldOverlay(_ isEnabled: Bool = true) -> some View {
        self
            .padding(.vertical, .padding8)
            .padding(.horizontal, .padding8)
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(Color.accentColor.opacity(isEnabled ? .one : .zero), lineWidth: .borderWidth)
            }
            .padding(.borderWidth)
    }

    func defaultViewPadding() -> some View {
        self
            .padding(.vertical, .padding8)
            .padding(.horizontal, .padding16)
    }

    #if !os(watchOS)
    func defaultListRowSettings() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
    }
    #endif

    func defaultListSettings() -> some View {
        self
            .listStyle(.plain)
            .frame(height: .defaultListHeight)
            .scrollContentBackground(.hidden)
    }

    func stepRowSettings() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, .padding8)
            .padding(.vertical, .padding4)
    }

    func contrastTo(color: Color) -> some View {
        var red: CGFloat = .zero
        var green: CGFloat = .zero
        var blue: CGFloat = .zero
        var alpha: CGFloat = .zero
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return  luminance < 0.6 ? self.foregroundColor(.lightContrast) : self.foregroundColor(.darkContrast)
    }

    func edgeShadows() -> some View {
        self
            .shadow(color: Color.lowerShadow, radius: 5, x: 5, y: 5)
            .shadow(color: Color.upperShadow, radius: 5, x: -2.5, y: -2.5)
    }
}
