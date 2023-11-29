import SwiftUI

public enum TextStyle: CaseIterable {
    /// 36 pt
    case largeTitle
    /// 20 pt
    case body
    /// 18 pt
    case callout
    /// 14 pt
    case footnote
}

public extension TextStyle {
    private typealias Fnt = Fonts.ProximaNova

    var color: Color { Color.text }

    var font: Font {
        switch self {
        case .largeTitle:
            return Fnt.bold.font(size: 32)
        case .body:
            return Fnt.bold.font(size: 20)
        case .callout:
            return Fnt.bold.font(size: 18)
        case .footnote:
            return Fnt.bold.font(size: 14)
        }
    }
}
