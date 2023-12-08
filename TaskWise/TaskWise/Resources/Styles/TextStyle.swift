import SwiftUI

public enum TextStyle: CaseIterable {
    /// 32 pt
    case largeTitle
    /// 26 pt
    case title
    /// 20 pt
    case body
    /// 18 pt
    case callout
    /// 14 pt
    case footnote
    /// 10 pt
    case widget
}

public extension TextStyle {
    private typealias Fnt = Fonts.ProximaNova

    var color: Color { Color.text }

    var font: Font {
        switch self {
        case .largeTitle:
            return Fnt.bold.font(size: 36)
        case .title:
            return Fnt.bold.font(size: 32)
        case .body:
            return Fnt.bold.font(size: 20)
        case .callout:
            return Fnt.bold.font(size: 18)
        case .footnote:
            return Fnt.bold.font(size: 14)
        case .widget:
            return Fnt.bold.font(size: 12)
        }
    }
}
