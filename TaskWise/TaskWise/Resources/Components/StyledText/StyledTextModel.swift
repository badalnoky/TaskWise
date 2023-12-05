import SwiftUI

public enum StyledTextModel {
    case title
    case base

    var textStyle: TextStyle {
        switch self {
        case .title: return .largeTitle
        case .base: return .body
        }
    }
}
