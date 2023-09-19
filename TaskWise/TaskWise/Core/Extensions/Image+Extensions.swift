import SwiftUI

extension Image {
    static let settings = Image(systemName: Str.iconsSettings)
    static let calendar = Image(systemName: Str.iconsCalendar)
    static let add = Image(systemName: Str.iconsAdd)
}

public extension Image {
    func fittedToSize(_ size: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}
