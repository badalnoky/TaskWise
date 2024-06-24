public extension Int {
    static var one: Int = 1
    static var two: Int = 2
    static var ten: Int = 10
    static var descriptionLineLimit: Int = 3

    var previous: Int {
        self - 1
    }

    var next: Int {
        self + 1
    }
}

extension Int {
    static var previous = 0
    static var next = 1
    static var taskWidgetMaxDisplayed = 3

    var projectedMax: Int {
        self + 2
    }
}

extension Int {
    static let weekDayCount: Int = 7
    static let yearWeekCount: Int = 52
    static let yearMonthCount: Int = 12
    static let plusOne: Int = 1
    static let minusOne: Int = -1
    static let maxMonthlyDayCount = 31

    var weekDayOffset: Int {
        switch self {
        case 1: return 6
        default: return self - 2
        }
    }
}

extension Int {
    static let maxHexCodeDigits: Int = 6
    static let colorGridMaxY: Int = 9
    static let colorGridRowCount: Int = 10
    static let colorGridMaxX: Int = 11
    static let colorGridColumnCount: Int = 12
    static let maxColorValue: Int = 255
}

extension Int {
    var weekdayIndice: Int {
        switch self {
        case 6: return 1
        default: return self + 2
        }
    }
}
