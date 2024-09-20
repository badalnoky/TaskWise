import SwiftUICore

public enum ColumnHeaderStyle {
    case macOS
    case iOS
}

extension ColumnHeaderStyle {
    var font: Font {
        switch self {
        case .macOS: return TextStyle.body.font
        case .iOS: return TextStyle.title.font
        }
    }
}
