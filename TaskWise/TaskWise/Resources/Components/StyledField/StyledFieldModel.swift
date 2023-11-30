public enum StyledFieldModel {
    case largeTitle
    case title
    case description
    case base

    var textStyle: TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title
        case .description: return .body
        case .base: return .body
        }
    }
}
