import Foundation

public enum StyledDateModel {
    case titleDate
    case date
    case weekday

    var textStyle: TextStyle {
        switch self {
        case .titleDate: return .largeTitle
        case .date: return .title
        case .weekday: return .title
        }
    }

    var format: Date.FormatStyle {
        switch self {
        case .titleDate: return .dateTime.year().month().day(.defaultDigits)
        case .date: return .dateTime.month(.wide).day(.defaultDigits)
        case .weekday: return .dateTime.weekday(.wide)
        }
    }
}
