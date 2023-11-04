import SwiftUI

extension Image {
    static let settings = Image(systemName: Str.iconsSettings)
    static let calendar = Image(systemName: Str.iconsCalendar)
    static let add = Image(systemName: Str.iconsAdd)
    static let edit = Image(systemName: Str.iconsEdit)
    static let check = Image(systemName: Str.iconsCheck)
    static let search = Image(systemName: Str.iconsSearch)
    static let list = Image(systemName: Str.iconsList)
    static let filter = Image(systemName: Str.iconsFilter)
    static let more = Image(systemName: Str.iconsMore)
}

public extension Image {
    func fittedToSize(_ size: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}
