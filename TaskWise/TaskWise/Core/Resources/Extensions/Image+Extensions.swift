import SwiftUI

extension Image {
    private typealias Icons = Str.Icons

    static let back = Image(systemName: Icons.back)
    static let settings = Image(systemName: Icons.settings)
    static let calendar = Image(systemName: Icons.calendar)
    static let add = Image(systemName: Icons.add)
    static let edit = Image(systemName: Icons.edit)
    static let check = Image(systemName: Icons.check)
    static let search = Image(systemName: Icons.search)
    static let list = Image(systemName: Icons.list)
    static let filter = Image(systemName: Icons.filter)
    static let more = Image(systemName: Icons.more)
    static let next = Image(systemName: Icons.forward)
    static let up = Image(systemName: Icons.up)
    static let down = Image(systemName: Icons.down)
    static let trash = Image(systemName: Icons.trash)
    static let close = Image(systemName: Icons.close)
}

public extension Image {
    func fittedToSize(_ size: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size, alignment: .center)
    }
}
